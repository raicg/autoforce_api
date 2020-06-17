class CreateBatches < ActiveRecord::Migration[6.0]
  def change
    create_table :batches do |t|
      t.string :reference, index: true
      t.string :purchase_channel, index: true

      t.timestamps
    end
  end
end
