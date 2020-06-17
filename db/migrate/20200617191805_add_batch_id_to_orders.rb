class AddBatchIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :batch, null: true, foreign_key: true
  end
end
