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

ActiveRecord::Schema.define(:version => 20130525093020) do

  create_table "categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name",       :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "categories", ["name", "parent_id"], :name => "index_categories_on_name_and_parent_id", :unique => true

  create_table "products", :force => true do |t|
    t.integer  "category_id",                 :null => false
    t.string   "name",        :default => "", :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.hstore   "properties"
  end

  add_index "products", ["properties"], :name => "products_properties"

  add_foreign_key "categories", "categories", :name => "categories_parent_id_fk", :column => "parent_id", :dependent => :delete

  add_foreign_key "products", "categories", :name => "products_category_id_fk", :dependent => :delete

end
