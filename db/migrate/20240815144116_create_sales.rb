class CreateSales < ActiveRecord::Migration[7.2]
  def change
    create_table :sales do |t|
      t.references :inventory_item, null: false, foreign_key: true
      t.integer :quantity_sold

      t.timestamps
    end
  end
end
