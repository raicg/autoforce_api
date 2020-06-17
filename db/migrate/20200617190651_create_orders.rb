class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :reference, index: true
      t.string :purchase_channel, index: true
      t.string :client_name, index: true
      t.string :address
      t.string :delivery_service, index: true
      t.float :total_value
      t.text :line_items
      t.integer :status, index: true

      t.timestamps
    end
  end
end
