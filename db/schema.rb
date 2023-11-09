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

ActiveRecord::Schema[7.0].define(version: 2023_11_02_154829) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "house_bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "house_id", null: false
    t.integer "number_of_days"
    t.float "price"
    t.date "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "house_name"
    t.string "house_image"
    t.index ["house_id"], name: "index_house_bookings_on_house_id"
    t.index ["user_id"], name: "index_house_bookings_on_user_id"
  end

  create_table "houses", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "description", null: false
    t.bigint "user_id", null: false
    t.integer "price_per_day", null: false
    t.string "image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_houses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "house_bookings", "houses"
  add_foreign_key "house_bookings", "users"
  add_foreign_key "houses", "users"
end
