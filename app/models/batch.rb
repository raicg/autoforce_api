class Batch < ApplicationRecord
  has_many :orders

  validates :orders, presence: true
  validate :orders_purchase_channel_must_be_the_same

  private

  def orders_purchase_channel_must_be_the_same
    errors.add("Every order on the batch must have the same purchase channel") unless orders.map { |o| o.purchase_channel }.uniq.length == 1
  end
end
