class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :category_id, :null => false

      t.timestamps
    end

    add_foreign_key(:products, :categories, :dependent => :delete)
  end
end
