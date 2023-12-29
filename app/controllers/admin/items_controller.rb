class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end
  
  def create
    is_active = ActiveRecord::Type::Boolean.new.cast(params[:item][:is_active])
    @item = Item.new(item_params.merge(is_active: is_active))
    if @item.save && @item.errors.empty?
      flash[:notice] = "商品の新規登録に成功しました。"
      redirect_to admin_item_path(@item)
    else
      flash.now[:alert] = "商品の新規登録に失敗しました。"
      render :new
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @genre = Genre.find(@item.genre_id)
  end
  
  def withdraw
    @item = Item.find(item.id)
    # is_activeカラムをfalseに変更することにより販売停止中フラグを立てる
    @item.update(is_active: true)
    reset_session
    redirect_to admin_items_path
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "You have updated item successfully."
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end
  
  
end
