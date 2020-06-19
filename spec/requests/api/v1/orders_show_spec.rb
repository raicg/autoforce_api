require 'rails_helper'

describe 'orders show on api v1', :type => :request do
  let!(:order) { create(:order) }

  before {get "/api/v1/orders/#{order.id}"}

  it 'show the order' do
    expect(JSON.parse(response.body)['data']['id']).to eq(order.id.to_s)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end