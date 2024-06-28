class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :orders
  has_many :carted_products



  def cart
    return self.carted_products.select { |item| item.status == 'carted'}
  end

  def cart_totals
    subtotal = 0
    self.cart.each {|item| subtotal += (item.product.total * item.quantity)}

    tax = subtotal * 0.09
    total = subtotal + tax

    return {subtotal: subtotal.round(2), tax: tax.round(2), total: total.round(2)}
  end

  def checkout
    valid = true
    self.cart.each do |item| 
      if item.quantity > item.product.in_stock
        valid = false
      end
    end

    if valid
      subtotal = 0
      self.cart.each {|item| subtotal += (item.product.total * item.quantity)}

      tax = subtotal * 0.09
      total = subtotal + tax

      order = Order.new(user_id: self.id, subtotal: subtotal, tax: tax, total: total)
      if order.save
        self.cart.each do |item| 
          item.product.in_stock -= item.quantity
          item.product.save

          item.status = 'purchased'
          item.order_id = order.id
          item.save
        end
      end
    end
    return valid
  end


end



# has_many :followed_users, foreign_key: :follower_id, class_name: "model name"
# has_many followed, through: followed_users
# belongs_to :follower, class_name: "User"
