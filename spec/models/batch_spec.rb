require 'rails_helper'

RSpec.describe Batch, type: :model do
  let!(:order){ create(:order) }
  let!(:batch){ create(:batch) }

  it 'reference cannot be nil' do
    batch.update(reference: nil)
    batch.reload
    expect(batch.reference).to_not be_nil
  end

  it 'purchase_channel cannot be nil' do
    batch.update(purchase_channel: nil)
    batch.reload
    expect(batch.purchase_channel).to_not be_nil
  end

  describe 'creating a new batch and orders' do
    let!(:order){ create(:order) }
    let!(:order2){ build(:order) }
    let!(:batch){ build(:batch) }

    context 'when orders doesnt have the same purchase channel' do
      it 'batch will not be persisted' do
        order2.purchase_channel = 'Iguatemi Store'
        batch.orders << [order, order2]
        batch.save
        expect(batch).to_not be_persisted
      end
    end
  end

  describe 'after create the batch' do
    it 'order in ready status should be attached to the batch with the same purchase channel' do
      order.reload
      expect(order.batch_id).to eq(batch.id)
    end
    
    it 'produce orders job should be enqueued' do
      expect(enqueued_jobs.size).to eq(1)
    end
  end

  describe 'after calling close_orders method' do
    it 'close orders job should be enqueued' do
      expect { batch.close_orders }.to change { enqueued_jobs.size }.by(1)
    end
  end
  
  describe 'after calling send_orders method' do
    it 'send orders job should be enqueued' do
      expect { batch.send_orders(order.delivery_service) }.to change { enqueued_jobs.size }.by(1)
    end
  end
end
