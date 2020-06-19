class Api::V1::FinancialsController < ApplicationController
  def index
    # Order.all.group_by(&:purchase_channel)
    json_answer = {}
    orders = []
    Order.find_in_batches.each do |batch|
      batch.each do |order|
        orders << order
      end
    end
    orders = orders.group_by(&:purchase_channel)
    orders.each do |orders_grouped|
      json_answer.merge!("#{orders_grouped[0]}": {
                              'orders_count': orders_grouped[1].count,
                              'total_value': orders_grouped[1].map { |o| o.total_value }.sum})
    end

    render json: json_answer, status: :ok
  end
end