class CartItem < ApplicationRecord
  has_one_attached :image
  belongs_to :item
  belongs_to :customer
  
  
  def subtotal
    item.price_with_tax * amount
  end
  
end
