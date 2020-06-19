class Order < ApplicationRecord
  include AASM

  belongs_to :batch, optional: true

  validates :reference, :purchase_channel, :client_name, :address,
            :delivery_service, :total_value, :line_items, presence: true
  validate :batch_id_cant_be_changed_after_production, on: :update, if: :batch_id_changed?
  validate :purchase_channel_should_be_equal_of_the_one_in_batch

  enum status: [:ready, :production, :closing, :sent]
  aasm column: :status, enum: true do
    state :ready, initial: true
    state :production
    state :closing
    state :sent

    event :produce_order do
      transitions from: :ready, to: :production
    end

    event :close_order do
      transitions from: :production, to: :closing
    end

    event :send_order do
      transitions from: :closing, to: :sent
    end
  end

  private

  def batch_id_cant_be_changed_after_production 
    unless ready?
      errors.add(:orders, I18n.t(:batch_id_cant_be_changed_after_production, scope: 'errors.messages'))
      throw :abort
    end
  end

  def purchase_channel_should_be_equal_of_the_one_in_batch
    if !batch_id.nil? && Batch.find(batch_id).purchase_channel != purchase_channel
      errors.add(:orders, I18n.t(:purchase_channel_should_be_the_same_as_the_batch, scope: 'errors.messages'))
      throw :abort
    end
  end
end
