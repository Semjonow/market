class Category < ActiveRecord::Base
  belongs_to :parent,   :class_name => "Category"
  has_many   :children, :class_name => "Category", :foreign_key => :prent_id
  has_many   :products

  attr_accessible :name
end
