class SendOrdersJob < ApplicationJob
  queue_as :send_orders

  def perform(batch_id, delivery_service)
    orders = Order.where(batch_id: batch_id, delivery_service: delivery_service)
    orders.each do |order|
      order.send_order! if order.may_send_order?
    end
  end
end