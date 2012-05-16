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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120502101538) do

  create_table "users", :primary_key => "user_id", :force => true do |t|
    t.string   "first_name",        :limit => 100
    t.string   "last_name",         :limit => 100
    t.string   "gender",            :limit => 100
    t.string   "birthdate",         :limit => 100
    t.string   "email"
    t.string   "username"
    t.boolean  "user_type"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "perishable_token"
    t.integer  "country_id"
    t.integer  "state_id"
    t.string   "city",              :limit => 100
    t.string   "zipcode"
    t.boolean  "is_active",                        :default => true
    t.string   "reset_code"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                           :default => false
  end

end
