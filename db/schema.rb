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

ActiveRecord::Schema.define(:version => 20111229183926) do

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "facebook_event_id"
    t.string   "descritption"
    t.string   "location"
    t.date     "startTime"
    t.date     "endTime"
    t.boolean  "privacy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "id_user"
    t.integer  "id_friend"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invites", :force => true do |t|
    t.string   "facebook_event_id"
    t.string   "name"
    t.string   "rsvp_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "fullname"
    t.string   "login"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "mail"
    t.integer  "facebookid",    :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
    t.string   "content_type"
    t.string   "file_name"
    t.binary   "binary_data"
  end

end
