class Image < ApplicationRecord
  belongs_to :product

  validates :url, uniqueness: true
end
