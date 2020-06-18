class Api::V1::BatchResource < JSONAPI::Resource
  attributes :reference, :delivery_service

  has_many :orders

  filter :reference, :delivery_service
end