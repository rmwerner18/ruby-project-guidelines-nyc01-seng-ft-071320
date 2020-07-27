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

ActiveRecord::Schema.define(version: 2020_07_27_212629) do

  create_table "event_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.integer "venue_id"
    t.datetime "date_time"
    t.string "type"
    t.string "genre"
    t.float "price"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "password"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "address"
  end

end
