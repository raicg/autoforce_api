require 'rails_helper'

describe 'orders index on api v1', :type => :request do
  let!(:orders) { create_list(:order, 5) }

  before {get '/api/v1/orders'}

  it 'returns all orders' do
    expect(JSON.parse(response.body)['data'].size).to eq(5)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end