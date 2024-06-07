class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id,  presence: true
  validates :product_id, presence: true
  validates :quantity,  presence: true, numericality: {greater_than: 0, less_than: 1000}
  validates :subtotal,  presence: true
  validates :tax,  presence: true
  validates :total,  presence: true
end




# * Write out all the steps necessary for your mini-capstone backend to allow users to purchase products. (aim for roughly 5 to 10 steps)
# * For now, a user can submit an order for any quantity of a single product (we are not implementing a “shopping cart” where an order contains multiple products).

# 1) add an orders create method and route

# 2) do not pass all the info as params, only the product id is needed. gather the information from the product at that point in time and pass those values to Order.new()

# 3) add authenticate condition

# 4) if authenticated, assign the current user id to its column