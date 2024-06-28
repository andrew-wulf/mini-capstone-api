class CartedProduct < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :user
  belongs_to :product

  validates :user_id,  presence: true
  validates :product_id, presence: true


  def purchase
    self.update(status: 'purchased')
  end

  def remove
    self.update(status: 'removed')
  end

  def set_quantity(x)
    self.update(quantity: x)
  end
end
