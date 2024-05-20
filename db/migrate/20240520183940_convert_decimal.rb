class ConvertDecimal < ActiveRecord::Migration[7.1]
  def change
    Product.connection.execute("UPDATE products SET price = price / 100 WHERE price > 0")
  end
end
