class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details
  end
  
  def update_status
    @order = Order.find(params[:id])
    new_status = params[:new_status]
    
    if @order.update(status: new_status)
      # 更新成功時の処理
      flash[:success] = "注文ステータスが更新されました。"
    else
      # 更新失敗時の処理
      flash[:error] = "注文ステータスの更新に失敗しました。"
    end
    
    redirect_to admin_order_path(@order)
  end
  
  private

  def order_params
    params.require(:order).permit(:status, :make_status)
  end
  
end
