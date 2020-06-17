class Batch < ApplicationRecord
  has_many :orders

  before_validation :attach_orders

  validates :orders, presence: true
  validate :orders_purchase_channel_must_be_the_same

  def send_orders(delivery_service)
    SendOrdersJob.perform_later(id, delivery_service)
  end

  private

  def attach_orders
    orders << Order.where(status: 'ready', purchase_channel: purchase_channel, batch_id: nil)
  end

  def orders_purchase_channel_must_be_the_same
    errors.add("Every order on the batch must have the same purchase channel") unless orders.map { |o| o.purchase_channel }.uniq.length == 1
  end
end
