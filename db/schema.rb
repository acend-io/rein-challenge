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

ActiveRecord::Schema.define(version: 2022_04_04_182854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drone_types", force: :cascade do |t|
    t.string "manufacturer", null: false
    t.string "model", null: false
    t.integer "wing_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["manufacturer", "model"], name: "drone_type_make_model", unique: true
  end

  create_table "drones", force: :cascade do |t|
    t.bigint "drone_type_id", null: false
    t.string "name", null: false
    t.string "faa_registration_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["drone_type_id"], name: "index_drones_on_drone_type_id"
    t.index ["faa_registration_number"], name: "index_drones_on_faa_registration_number", unique: true
  end

  create_table "pilots", force: :cascade do |t|
    t.string "name", null: false
    t.integer "license_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "drones", "drone_types"
end
