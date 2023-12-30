class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.all
    @genres = Genre.all
    @item = Item.find(params[:id])
  end
  
  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
  
end
