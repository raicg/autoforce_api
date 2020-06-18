class Order < ApplicationRecord
  include AASM

  belongs_to :batch, optional: true

  validates :reference, :purchase_channel, :client_name, :address,
            :delivery_service, :total_value, :line_items, presence: true

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
end
