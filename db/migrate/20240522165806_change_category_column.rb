class ChangeCategoryColumn < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :category, :string
    add_column :products, :categories, :text, array: true, default: []
  end
end
