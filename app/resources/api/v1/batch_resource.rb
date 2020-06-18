class Api::V1::BatchResource < JSONAPI::Resource
  attributes :reference, :purchase_channel

  has_many :orders

  filter :reference, :purchase_channel
end