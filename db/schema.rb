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

ActiveRecord::Schema.define(version: 20140611201812) do

  create_table "activities", force: true do |t|
    t.string  "category"
    t.integer "category_weight"
    t.integer "user_id"
  end

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string "name"
  end

  create_table "leagues", force: true do |t|
    t.string  "name"
    t.integer "company_id"
  end

  create_table "matchups", force: true do |t|
    t.integer "first_team_id"
    t.integer "second_team_id"
    t.integer "week_id"
    t.integer "winner"
    t.integer "season_id"
  end

  create_table "seasons", force: true do |t|
    t.integer "league_id"
    t.date    "start_date"
    t.date    "end_date"
    t.integer "number"
  end

  create_table "teams", force: true do |t|
    t.string  "name"
    t.integer "league_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.boolean  "is_captain"
    t.boolean  "is_commissioner"
    t.integer  "company_id"
    t.integer  "league_id"
    t.integer  "team_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.string   "refresh_token"
    t.string   "instance_url"
    t.string   "sfdc_user_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "weeks", force: true do |t|
    t.date    "start_date"
    t.date    "end_date"
    t.integer "season_id"
    t.integer "number"
  end

end
