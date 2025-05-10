class CreateLineItems < ActiveRecord::Migration[7.1]
  def change
    create_table :line_items do |t|
      t.references :order, null: false, foreign_key: true
      t.string :sku, null: false
      t.integer :quantity, null: false
      t.boolean :original, default: true, null: false
      t.timestamps
    end
  end
end
