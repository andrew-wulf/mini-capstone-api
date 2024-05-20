class SetDefaults < ActiveRecord::Migration[7.1]
  def change
    Product.connection.execute("UPDATE products SET on_sale = 0 WHERE on_sale IS NULL")
    Product.connection.execute("UPDATE products SET price = 5 WHERE price IS NULL")
    Product.connection.execute("DELETE FROM products WHERE name IS NULL")
    change_column :products, :on_sale, :integer, default: 0, null: false
    change_column :products, :price, :decimal, precision: 9, scale: 2, null: false
    change_column :products, :name, :string, limit: 90, null: false
  end
end
