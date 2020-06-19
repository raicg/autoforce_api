require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:order){ create(:order) }
  let!(:batch){ create(:batch) }

  it 'reference cannot be nil' do
    order.update(reference: nil)
    order.reload
    expect(order.reference).to_not be_nil
  end

  it 'purchase_channel cannot be nil' do
    order.update(purchase_channel: nil)
    order.reload
    expect(order.purchase_channel).to_not be_nil
  end

  it 'client_name cannot be nil' do
    order.update(client_name: nil)
    order.reload
    expect(order.client_name).to_not be_nil
  end

  it 'address cannot be nil' do
    order.update(address: nil)
    order.reload
    expect(order.address).to_not be_nil
  end

  it 'delivery_service cannot be nil' do
    order.update(delivery_service: nil)
    order.reload
    expect(order.delivery_service).to_not be_nil
  end

  it 'total_value cannot be nil' do
    order.update(total_value: nil)
    order.reload
    expect(order.total_value).to_not be_nil
  end

  it 'line_items cannot be nil' do
    order.update(reference: nil)
    order.reload
    expect(order.line_items).to_not be_nil
  end

  describe 'updating or creating a new order especifying the batch' do
    let!(:order2){ build(:order) }

    context 'when the new order has a different purchase_channel' do
      it 'it should not attach to the batch' do
        order2.purchase_channel = 'Iguatemi Store'
        batch.orders << order2
        expect(batch.orders.count).to eq(1)
      end
    end
  end

  describe 'update batch_id' do
    context 'when order status is ready' do
      it 'it will works' do
        order.update(batch_id: batch.id)
        order.reload
        expect(order.batch_id).to eq(batch.id)
      end
    end

    context 'when order status is production' do
      it 'it will not works' do
        order.update(batch_id: nil)
        order.reload
        expect(order.batch_id).to eq(batch.id)
      end
    end

    context 'when order status is closing' do
      it 'it will not works' do
        order.update(batch_id: nil)
        order.reload
        expect(order.batch_id).to eq(batch.id)
      end
    end

    context 'when order status is sent' do
      it 'it will not works' do
        order.update(batch_id: nil)
        order.reload
        expect(order.batch_id).to eq(batch.id)
      end
    end
  end
end
