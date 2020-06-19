require 'rails_helper'

describe 'batches show on api v1', :type => :request do
  let!(:order) { create(:order) }
  let!(:batch) { create(:batch) }

  before {get "/api/v1/batches/#{batch.id}"}

  it 'show the batch' do
    expect(JSON.parse(response.body)['data']['id']).to eq(batch.id.to_s)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end