# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_17_175758) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.string "reference"
    t.string "purchase_channel"
    t.string "client_name"
    t.string "address"
    t.string "delivery_service"
    t.float "total_value"
    t.text "line_items"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_name"], name: "index_orders_on_client_name"
    t.index ["delivery_service"], name: "index_orders_on_delivery_service"
    t.index ["purchase_channel"], name: "index_orders_on_purchase_channel"
    t.index ["reference"], name: "index_orders_on_reference"
    t.index ["status"], name: "index_orders_on_status"
  end

end
