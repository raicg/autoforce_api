require 'rails_helper'

describe 'batches send orders on api v1', :type => :request do
  let!(:order) { create(:order) }
  let!(:batch) { create(:batch) }

  before {post "/api/v1/batches/#{batch.id}/send_orders", params: { delivery_service: order.delivery_service }}

  it 'show status ok' do
    expect(JSON.parse(response.body)['status']).to eq('ok')
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end