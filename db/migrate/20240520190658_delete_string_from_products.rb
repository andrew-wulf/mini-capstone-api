class DeleteStringFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :string, :string
  end
end
