class Api::V1::OrderResource < JSONAPI::Resource
  attributes :reference, :purchase_channel, :client_name, :address,
             :delivery_service, :total_value, :line_items, :status

  has_one :batch

  filter :reference, :purchase_channel, :client_name, :status, 
         :delivery_service

  def self.default_sort
    [{field: 'created_at', direction: :desc}]
  end
end