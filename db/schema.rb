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

ActiveRecord::Schema.define(version: 2021_12_08_173813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "planes", force: :cascade do |t|
    t.string "model"
    t.string "registration"
    t.text "description"
    t.decimal "cruise_speed"
    t.decimal "tour_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "planes_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "plane_id", null: false
    t.index ["plane_id", "user_id"], name: "index_planes_users_on_plane_id_and_user_id"
    t.index ["user_id", "plane_id"], name: "index_planes_users_on_user_id_and_plane_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.string "reservation_date"
    t.bigint "user_id", null: false
    t.bigint "plane_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plane_id"], name: "index_reservations_on_plane_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "reservations", "planes"
  add_foreign_key "reservations", "users"
end
