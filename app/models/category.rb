class Category < ApplicationRecord
  has_many  :category_products
  has_many :products, through: :category_products

  validates :name,  presence: true, uniqueness: true

  # def products
  #   return self.category_product.map {|cp| cp.product}
  # end

end
