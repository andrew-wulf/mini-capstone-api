class Product < ApplicationRecord
  validates :name,  presence: true, uniqueness: true
  validates :price,  presence: true, numericality: {greater_than: 0, less_than: 10000000}
  validates :category,  presence: true
  validates :in_stock,  presence: true, numericality: { only_integer: true }
  validates :on_sale, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 100}

  def display
    @data = self.attributes
    @price = self.get_price

    @data['price'] = self.display_currency(@price)
    @data['total'] = self.display_currency(self.total)
    return @data
  end

  def is_discounted?
    return @price <= 10
  end

  def tax
    return (@price * 0.09).round(2)
  end

  def total
    return @price + self.tax
  end

  def display_currency(amount)
    return "$#{amount.to_s}"
  end

  def get_price
    return self.price * ((100 - self.on_sale) / 100)
  end

end
