require 'rails_helper'

describe 'batches index on api v1', :type => :request do
  let!(:order) { create(:order) }
  let!(:batch) { create(:batch) }
  let!(:order2) { create(:order) }
  let!(:batch2) { create(:batch) }

  before {get '/api/v1/batches'}

  it 'returns all batches' do
    expect(JSON.parse(response.body)['data'].size).to eq(2)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end