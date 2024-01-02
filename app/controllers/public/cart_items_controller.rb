class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
      @cart_item = CartItem.new
      @cart_items = CartItem.all
  end
  
  def destroy_all
    CartItem.destroy_all
    redirect_back(fallback_location: root_path)
  end
  
  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_back(fallback_location: root_path)
  end
end
