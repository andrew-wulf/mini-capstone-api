class RemoveCategories < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :categories, :text
  end
end
