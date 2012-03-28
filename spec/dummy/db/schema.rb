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

ActiveRecord::Schema.define(:version => 20120326091115) do

  create_table "cart_items", :force => true do |t|
    t.integer  "cartable_type",                               :null => false
    t.integer  "cartable_id",                                 :null => false
    t.integer  "cart_id",                                     :null => false
    t.decimal  "price",         :precision => 8, :scale => 2
    t.integer  "quantity"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "cart_items", ["cart_id"], :name => "index_cart_items_on_cart_id"
  add_index "cart_items", ["cartable_id", "cartable_type"], :name => "index_cart_items_on_cartable_id_and_cartable_type"

  create_table "carts", :force => true do |t|
    t.string   "shopper_type"
    t.integer  "shopper_id"
    t.string   "state"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "carts", ["shopper_id", "shopper_type"], :name => "index_carts_on_shopper_id_and_shopper_type"
  add_index "carts", ["state"], :name => "index_carts_on_state"

  create_table "products", :force => true do |t|
    t.string   "title"
    t.decimal  "price",      :precision => 8, :scale => 2
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
