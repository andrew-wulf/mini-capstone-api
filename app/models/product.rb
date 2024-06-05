class Product < ApplicationRecord
  belongs_to :supplier
  has_many :image
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

  def display
    @data = self.attributes
    @price = self.get_price

    @data['initial_price'] = self.attributes['price']
    @data['price'] = self.display_currency(@price)
    @data['total'] = self.display_currency(self.total)

    @data['images'] = self.image.map {|i| i.url}
    @data['supplier'] = {name: self.supplier.name, email: self.supplier.email, phone_number: self.supplier.phone_number}
    return @data
  end

  def is_discounted?
    return @price <= 10
  end

  def tax
    return (@price * 0.09).round(2)
  end

  def total
    return (@price + self.tax)
  end

  def display_currency(amount)
    return "$#{amount.to_s}"
  end

  def get_price
    return ((self.attributes['price'] * (100 - self.on_sale)) / 10000).round(2)
  end

  def check_validity
    products = Product.all
    products.each do |prod|
      if not prod.valid?
        pp prod
        pp prod.errors
      end
    end
  end
end
