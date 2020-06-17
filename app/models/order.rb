class Order < ApplicationRecord
  belongs_to :batch, optional: true
end
