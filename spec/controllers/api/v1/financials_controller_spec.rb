require 'rails_helper'

describe Api::V1::FinancialsController, type: :controller do
  let!(:orders) { create_list(:order, 2) }

  describe "GET index" do
    it 'returns http success' do
      get 'index'

      expect(response).to be_successful
    end

    it 'should return the orders count of the purchase channels' do
      get 'index'
      
      expect(JSON.parse(response.body)[orders.first.purchase_channel]['orders_count']).to eq(orders.count)
    end

    it 'should return the total value of all orders of the purchase channels' do
      get 'index'
      
      expect(JSON.parse(response.body)[orders.first.purchase_channel]['total_value']).to eq(orders.map { |o| o.total_value }.sum)
    end
  end
end