class Order < ApplicationRecord
  belongs_to :batch, optional: true

  enum status: [:ready, :production, :closing, :sent]

  aasm column: :state, enum: true do
    state :ready, initial: true
    state :production
    state :closing
    state :sent

    event :produce do
      transitions from: :ready, to: :production
    end

    event :close do
      transitions from: :production, to: :closing
    end

    event :send do
      transitions from: :closing, to: :sent
    end
  end
end
