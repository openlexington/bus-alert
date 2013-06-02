# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130602042208) do

  create_table "bus_arrivals", force: true do |t|
    t.integer  "bus_no"
    t.integer  "stop_id"
    t.datetime "scheduled_at"
    t.datetime "estimated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bus_routes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bus_stops", id: false, force: true do |t|
    t.string   "name"
    t.decimal  "lat"
    t.decimal  "long"
    t.integer  "route_id"
    t.integer  "stop_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bus_stops", ["stop_num"], name: "index_bus_stops_on_stop_num"

end
