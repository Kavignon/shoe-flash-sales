class CreateInventoryItems < ActiveRecord::Migration[7.2]
  def change
    create_table :inventory_items do |t|
      t.references :store, null: false, foreign_key: true
      t.references :shoe, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
