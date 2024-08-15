# frozen_string_literal: true

# Clear existing data to avoid duplication on subsequent seed runs
Store.destroy_all
Shoe.destroy_all
InventoryItem.destroy_all
Sale.destroy_all

stores = ['ALDO Centre Eaton', 'ALDO Destiny USA Mall', 'ALDO Pheasant Lane Mall', 'ALDO Holyoke Mall', 'ALDO Maine Mall', 'ALDO Crossgates Mall', 'ALDO Burlington Mall', 'ALDO Solomon Pond Mall', 'ALDO Auburn Mall', 'ALDO Waterloo Premium Outlets']

stores.each do |store_name|
  Store.create!(name: store_name)
end

shoes = [
  { brand_name: 'Nike', style: 'Running', color: 'Blue', size: 10.5, price: 99.99 },
  { brand_name: 'Adidas', style: 'Basketball', color: 'Black', size: 9.0, price: 89.99 },
  { brand_name: 'Puma', style: 'Casual', color: 'White', size: 11.0, price: 79.99 }
]

shoes.each do |shoe_data|
  Shoe.create!(shoe_data)
end

minimum_shoes_in_inventory = InventoryItem::LOW_STOCK_THRESHOLD / 2
maximum_shoes_in_inventory = InventoryItem::HIGH_STOCK_THRESHOLD * 2

Store.find_each do |store|
  Shoe.find_each do |shoe|
    inventory_item = InventoryItem.create!(
      store: store,
      shoe: shoe,
      quantity: rand(minimum_shoes_in_inventory..maximum_shoes_in_inventory)
    )
  end
end

puts 'Seed data created successfully.'
