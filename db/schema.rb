# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_08_15_144116) do
  create_table "inventory_items", force: :cascade do |t|
    t.integer "store_id", null: false
    t.integer "shoe_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shoe_id"], name: "index_inventory_items_on_shoe_id"
    t.index ["store_id"], name: "index_inventory_items_on_store_id"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "inventory_item_id", null: false
    t.integer "quantity_sold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_item_id"], name: "index_sales_on_inventory_item_id"
  end

  create_table "shoes", force: :cascade do |t|
    t.string "brand_name"
    t.string "style"
    t.string "color"
    t.decimal "size", precision: 4, scale: 1
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "inventory_items", "shoes"
  add_foreign_key "inventory_items", "stores"
  add_foreign_key "sales", "inventory_items"
end
