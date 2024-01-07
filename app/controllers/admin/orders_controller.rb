class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @cart_items = CartItem.all
  end
  
  def show
    @cart_items = CartItem.all
    
  end
  
end
