class Product < ApplicationRecord
  belongs_to :supplier
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


  def misc_func
    #Insert database operations here
    # products = Product.all
    # products.each do |prod|
    #   des = prod.description
    #   if des 
    #     x = des.index("developed by ") + 13
    #     y = des.index(",", x)
    #     brand = des[x...y]
    #     res = Supplier.find_by(name: brand)
        
    #     if res
    #       id = res.id
    #     else
    #       supp = Supplier.new(name: brand, email: "products@#{name.gsub(/\s+/, "")}.org", phone_number: Faker::Base.numerify('###-###-####'))
    #       supp.save
    #     end
    #     prod.supplier_id = id
    #     prod.save
    #   end
    # end
    
    # 300.times do
    #   brand = Faker::Commerce.brand
    #   res = Supplier.where(name: brand)
    #   i = 0
    #   while i < res.length
    #     row = res[i]
    #     if i > 0
    #       row.destroy
    #     end
    #     i +=1
    #   end
    # end
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
