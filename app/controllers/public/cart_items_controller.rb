class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @cart_items = current_customer.cart_items.all
  end
  
  def create
    # もし元々カート内に「同じ商品」がある場合、「数量を追加」更新・保存する
    @cart_item = current_customer.cart_items.new(cart_item_params)
    #元々カート内にあるもの「item_id」　
    #今追加したparams[:cart_item][:item_id])
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      #cart_item.amountに今追加したparams[:cart_item][:amount]を加える
      #.to_iとして数字として扱う
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to cart_items_path
    # もしカート内に「同じ」商品がない場合は通常の保存処理
    elsif @cart_item.save
      @cart_items = current_customer.cart_items.all
      render :index
    # 保存できなかった場合
    else
      render :index
    end
  end
  
  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_back(fallback_location: cart_items_path)
  end
  
  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  
  private
 
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :price, :amount)
  end
  
end
