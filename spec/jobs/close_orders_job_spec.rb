require 'rails_helper'

RSpec.describe CloseOrdersJob, type: :job do
  it 'queues the job' do
    expect{ CloseOrdersJob.perform_later(1) }.to have_enqueued_job
  end

  it 'is in close orders queue' do
    expect(CloseOrdersJob.new.queue_name).to eq('autoforce_test_close_orders')
  end

  describe 'when performing the queue' do
    let!(:order) { create(:order) }
    let!(:batch) { create(:batch) }
    it 'should change order status to closing' do
      order.produce_order!
      CloseOrdersJob.new.perform(batch.id)
      order.reload
      expect(order.status).to eq('closing')
    end
  end
end
