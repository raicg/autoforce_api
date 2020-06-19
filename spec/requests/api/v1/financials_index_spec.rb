require 'rails_helper'

describe 'financials index on api v1', :type => :request do
  let!(:orders) { create_list(:order, 2) }

  before {get '/api/v1/financials'}

  it 'returns orders count of the purchase channels' do
    expect(JSON.parse(response.body)[orders.first.purchase_channel]['orders_count']).to eq(orders.count)
  end

  it 'returns total value of the purchase channels' do
    expect(JSON.parse(response.body)[orders.first.purchase_channel]['total_value']).to eq(orders.map { |o| o.total_value }.sum)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end