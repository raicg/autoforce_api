class CloseOrdersJob < ApplicationJob
  queue_as :close_orders

  def perform(batch_id)
    orders = Order.where(batch_id: batch_id)
    orders.each do |order|
      order.close_order! if order.may_close_order?
    end
  end
end