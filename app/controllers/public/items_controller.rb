class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.all
    @genres = Genre.all
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem
    @genres = Genre.all
  end
  
  private
  def item_params
    params.require(:items).permit(:name, :introduction, :price, :genre_id)
  end
  
end
