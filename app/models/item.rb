class Item < ApplicationRecord
  # ActiveStorageを使って画像を持たせる
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  
  def item_status
    if is_active == true
      "販売中"
    else
      "販売停止中"
    end
  end
  
  def with_tax_price
    (price * 1.1).floor
  end
  
end
