require 'rails_helper'

RSpec.describe ProduceOrdersJob, type: :job do
  it 'queues the job' do
    expect{ ProduceOrdersJob.perform_later(1) }.to have_enqueued_job
  end

  it 'is in produce orders queue' do
    expect(ProduceOrdersJob.new.queue_name).to eq('autoforce_test_produce_orders')
  end

  describe 'when performing the queue' do
    let!(:order) { create(:order) }
    let!(:batch) { create(:batch) }
    it 'should change order status to production' do
      ProduceOrdersJob.new.perform(batch.id)
      order.reload
      expect(order.status).to eq('production')
    end
  end
end
