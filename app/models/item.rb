class Item < ApplicationRecord
  
  def item_status
    if is_active == true
      "販売中"
    else
      "販売停止中"
    end
  end
  
end
