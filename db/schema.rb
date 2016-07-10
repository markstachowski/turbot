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

ActiveRecord::Schema.define() do

  create_table "messages", force: :cascade do |t|
    t.text     "content",              limit: 65535, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.datetime "sent_at"
    t.integer  "sender_profile_id",    limit: 4
    t.integer  "recipient_profile_id", limit: 4
  end

  add_index "messages", ["recipient_profile_id"], name: "recipient_profile_id", using: :btree
  add_index "messages", ["sender_profile_id"], name: "sender_profile_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "pof_key",      limit: 255,                   null: false
    t.string   "username",     limit: 255,                   null: false
    t.text     "page_content", limit: 65535,                 null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "unavailable",                default: false
  end

  add_index "profiles", ["pof_key"], name: "profiles_pof_key_index", unique: true, using: :btree
  add_index "profiles", ["username"], name: "profiles_username_index", unique: true, using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "name",       limit: 255,   null: false
    t.text     "matchers",   limit: 65535, null: false
    t.text     "message",    limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "topics", ["name"], name: "index_topics_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "pof_username", limit: 255, null: false
    t.string   "pof_password", limit: 255, null: false
    t.string   "name",         limit: 255, null: false
    t.integer  "profile_id",   limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_foreign_key "messages", "profiles", column: "recipient_profile_id", name: "messages_ibfk_3"
  add_foreign_key "messages", "profiles", column: "sender_profile_id", name: "messages_ibfk_2"
end