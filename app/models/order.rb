class Order < ApplicationRecord
  include AASM

  belongs_to :batch, optional: true

  validates :reference, :purchase_channel, :client_name, :address,
            :delivery_service, :total_value, :line_items, presence: true
  validate :batch_id_cant_be_changed_after_production, on: :update, if: :batch_id_changed?

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
    end
  end
end
