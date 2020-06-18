class ProduceOrdersJob < ApplicationJob
  queue_as :produce_orders

  def perform(batch_id)
    orders = Order.where(batch_id: batch_id)
    orders.each do |order|
      order.produce_order! if order.may_produce_order?
    end
  end
end