class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :image_url
      t.string :description
      t.string :category
      t.string :string
      t.integer :in_stock
      t.integer :on_sale

      t.timestamps
    end
  end
end
