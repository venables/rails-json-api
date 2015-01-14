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

ActiveRecord::Schema.define(version: 20150114023042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "password_resets", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id",    null: false
    t.string   "token",      null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "password_resets", ["token"], name: "index_password_resets_on_token", unique: true, using: :btree

  create_table "sessions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id",    null: false
    t.string   "token",      null: false
    t.datetime "expires_at", null: false
    t.inet     "ip_address", null: false
    t.text     "user_agent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sessions", ["token"], name: "index_sessions_on_token", unique: true, using: :btree
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "last_login_at",   null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "password_resets", "users"
  add_foreign_key "sessions", "users"
end
