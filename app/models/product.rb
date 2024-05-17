class Product < ApplicationRecord


  def display
    @data = self.attributes
    @price = self.get_price

    @data['price'] = self.display_currency(@price)
    @data['total'] = self.display_currency(self.total)
    return @data
  end

  def is_discounted?
    return @price <= 1000
  end

  def tax
    return (@price * 9) / 100
  end

  def total
    return @price + self.tax
  end

  def display_currency(cents)
    amount = cents.to_s
    return '$' + amount[...-2] + '.' + amount[-2...]
  end

  def get_price
    factor = (100 - self.on_sale)
    return (self.price * factor) / 100
  end

end
