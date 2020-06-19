require 'rails_helper'

describe Api::V1::BatchesController, type: :controller do
  let!(:order) { create(:order) }
  let!(:batch) { create(:batch) }

  describe "POST close_orders" do
    it 'returns http success' do
      post 'close_orders', params: { id: batch.id }

      expect(response).to be_successful
    end

    it 'close orders job should be enqueued' do
      expect { post 'close_orders', params: { id: batch.id } }.to change { enqueued_jobs.size }.by(1)
    end

    context 'when batch_id is invalid' do
      it 'should returns a json with a not found status' do
        post 'close_orders', params: { id: 99999 }

        expect(JSON.parse(response.body)['status']).to eq('not_found')
      end
    end
  end

  describe "POST send_orders" do
    it 'returns http success' do
      post 'send_orders', params: { id: batch.id, delivery_service: order.delivery_service }

      expect(response).to be_successful
    end

    it 'send orders job should be enqueued' do
      expect { post 'send_orders', params: { id: batch.id, delivery_service: order.delivery_service } }.to change { enqueued_jobs.size }.by(1)
    end

    context 'when batch_id is invalid' do
      it 'should returns a json with a not found status' do
        post 'send_orders', params: { id: 99999, delivery_service: order.delivery_service }

        expect(JSON.parse(response.body)['status']).to eq('not_found')
      end
    end
    
    context 'when delivery service is not given as parameter' do
      it 'should returns a json with a bad request status' do
        post 'send_orders', params: { id: batch.id }

        expect(JSON.parse(response.body)['status']).to eq('bad_request')
      end
    end
    
  end
end