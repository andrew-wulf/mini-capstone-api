class AddColorToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :color, :string
    add_column :products, :material, :string
    add_column :products, :weight, :integer
    add_column :products, :country_of_origin, :string
  end
end
