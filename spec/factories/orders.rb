FactoryBot.define do
  factory :order do
    reference { 'BR102030' }
    purchase_channel { 'Site BR' }
    client_name { 'São Clênio' }
    address { 'Av. Amintas Barros Nº 3700 - Torre Business, Sala 702 - Lagoa Nova CEP: 59075-250' }
    delivery_service { 'SEDEX' }
    total_value { 123.30 }
    line_items { ' [{sku: case-my-best-friend, model: iPhone X, case type: Rose Leather}, {sku: powebank-sunshine, capacity: 10000mah}, {sku: earphone-standard, color: white}]' }
    status { 0 }
  end
end
