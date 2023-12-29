class Item < ApplicationRecord
  # ActiveStorageを使って画像を持たせる
  has_one_attached :image
  belongs_to :genre
  
  def item_status
    if is_active == true
      "販売中"
    else
      "販売停止中"
    end
  end
  
  def price_with_tax
    (price * 1.1).to_i
  end
  
end
