class Product < ApplicationRecord
  belongs_to :supplier
  has_many :images
  has_many :orders
  has_many :category_products
  has_many :categories, through: :category_products
  
  validates :name,  presence: true
  validates :price,  presence: true, numericality: {greater_than: 0, less_than: 10000000}
  validates :in_stock,  presence: true, numericality: { only_integer: true }
  validates :on_sale, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 100}

  validate :unique_name_or_color_combination



  def unique_name_or_color_combination
    first_entry = self.class.find_by(name:self.name, color: self.color)
    if first_entry
      if self.id != first_entry.id
        errors.add(:base, "Name and Color combination must be unique")
        pp first_entry
      end
    end
  end


  def is_discounted?
    return @price <= 10
  end

  def total
    return ((self.price * (100 - self.on_sale)) / 100).round(2)
  end




end
