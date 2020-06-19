require 'rails_helper'

describe 'batches close orders on api v1', :type => :request do
  let!(:order) { create(:order) }
  let!(:batch) { create(:batch) }

  before {post "/api/v1/batches/#{batch.id}/close_orders"}

  it 'show status ok' do
    expect(JSON.parse(response.body)['status']).to eq('ok')
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end