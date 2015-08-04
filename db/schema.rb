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

ActiveRecord::Schema.define(version: 20150724214206) do

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.string   "thumbnail_url"
    t.string   "openlibrary_key"
    t.integer  "first_publish_year"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "reader_id"
    t.integer  "book_id"
    t.boolean  "has_read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "relationships", ["book_id"], name: "index_relationships_on_book_id"
  add_index "relationships", ["has_read"], name: "index_relationships_on_has_read"
  add_index "relationships", ["reader_id", "book_id"], name: "index_relationships_on_reader_id_and_book_id", unique: true
  add_index "relationships", ["reader_id"], name: "index_relationships_on_reader_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
