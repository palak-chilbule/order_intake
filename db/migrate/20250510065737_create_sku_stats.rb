class CreateSkuStats < ActiveRecord::Migration[7.1]
  def change
    create_table :sku_stats do |t|
      t.string :sku, null: false
      t.string :week, null: false
      t.integer :total_quantity, null: false, default: 0
      t.timestamps
    end
  end
end
