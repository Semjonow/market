class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.string  :name,      :null => false, :default => ""

      t.timestamps
    end

    add_index(:categories, [:name, :parent_id], :unique => true)
    add_foreign_key(:categories, :categories, :column => :parent_id, :dependent => :delete)
  end
end
