# frozen_string_literal: true
# 
class CreateShoes < ActiveRecord::Migration[7.2]
  def change
    create_table :shoes do |t|
      t.string :brand_name
      t.string :style
      t.string :color
      t.decimal :size, precision: 4, scale: 1
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
