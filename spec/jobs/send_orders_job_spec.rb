require 'rails_helper'

RSpec.describe SendOrdersJob, type: :job do
  it 'queues the job' do
    expect{ SendOrdersJob.perform_later(1) }.to have_enqueued_job
  end

  it 'is in send orders queue' do
    expect(SendOrdersJob.new.queue_name).to eq('autoforce_test_send_orders')
  end

  describe 'when performing the queue' do
    let!(:order) { create(:order) }
    let!(:batch) { create(:batch) }
    it 'should change order status to sent' do
      order.produce_order!
      order.close_order!
      SendOrdersJob.new.perform(batch.id, order.delivery_service)
      order.reload
      expect(order.status).to eq('sent')
    end
  end
end
