# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_05_12_205839) do

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.date "work_date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.float "shift_hour"
    t.integer "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_schedules_on_employee_id"
    t.index ["start_time", "end_time"], name: "index_schedules_on_start_time_and_end_time", unique: true
    t.index ["work_date", "employee_id"], name: "index_schedules_on_work_date_and_employee_id"
    t.index ["work_date"], name: "index_schedules_on_work_date"
  end

end
