class ImagesColumn < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :image_url, :string
    add_column :products, :images_id, :integer

    add_column :images, :product_id, :integer
  end
end
