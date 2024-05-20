class UpdateTable < ActiveRecord::Migration[7.1]
  def change
    Product.connection.execute("DELETE FROM products WHERE price IS NULL")
    Product.connection.execute("DELETE FROM products WHERE name IS NULL")
    Product.connection.execute("UPDATE products SET on_sale = 0 WHERE on_sale IS NULL")
    Product.connection.execute("UPDATE products SET in_stock = 0 WHERE in_stock IS NULL")

    change_table :products do |t|
      t.change :name, :string, limit: 90, null: false
      t.change :price, :decimal, precision: 9, scale: 2, null: false
      t.change :image_url, :string
      t.change :description, :string
      t.change :category, :string, null: false
      t.change :in_stock, :integer, null: false, default: 0
      t.change :on_sale, :integer, default: 0, null: false
    end
  end
end
