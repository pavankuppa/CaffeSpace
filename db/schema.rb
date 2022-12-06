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

ActiveRecord::Schema[7.0].define(version: 2022_12_06_122746) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offer_items", force: :cascade do |t|
    t.bigint "offer_id"
    t.bigint "variant_id", null: false
    t.boolean "free", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_offer_items_on_offer_id"
    t.index ["variant_id"], name: "index_offer_items_on_variant_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string "name"
    t.string "offer_type"
    t.integer "discount_percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "item_name", null: false
    t.string "offer_name"
    t.string "offer_type"
    t.boolean "free"
    t.integer "discount_percentage"
    t.string "quantity"
    t.decimal "price", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "order_number"
    t.decimal "order_price", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "inprogress"
  end

  create_table "variants", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.string "quantity"
    t.decimal "price", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_variants_on_item_id"
  end

  add_foreign_key "offer_items", "variants"
  add_foreign_key "order_items", "orders"
  add_foreign_key "variants", "items"
end
