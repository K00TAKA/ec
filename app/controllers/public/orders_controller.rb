class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
  end
  
  def create
    @order = Order.new
    @order.customer_id = current_customer.id
    @order.postage = 800
    @cart_items = CartItem.where(customer_id: current_customer.id)
    ary = []
    @cart_items.each do |cart_item|
      ary << cart_item.item.price*cart_item.amount
    end
    @cart_items_price = ary.sum
    @order.total_payment = @order.postage + @cart_items_price
    @order.payment_method = params[:order][:payment_method]
    if @order.payment_method == "クレジットカード"
      @order.status = 0
    else
      @order.status = 1
    end
      
    address_type = params[:order][:address_type]
    case address_type
    when "customer_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    when "registered_address"
      Address.find(params[:order][:registered_address_id])
      selected = Address.find(params[:order][:registered_address_id])
      @order.postal_code = selected.postal_code
      @order.address = selected.address
      @order.name = selected.name
    when "new_address"
      @order.postal_code = params[:order][:new_postal_code]
      @order.address = params[:order][:new_address]
      @order.name = params[:order][:new_name]
    end
    
    if @order.save
      if @order.status == 1
        @cart_items.each do |cart_item|
          OrderDetail.creat!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 0)
        end
      else
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price_with_tax: cart_item.item.price, amount: cart_item.amount, making_status: 1)
        end
      end
      @cart_items.destroy_all
      redirect_to complete_orders_path
    else
      render :items
    end
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @postage = 800 
    @selected_payment_method = params[:order][:payment_method]
    
    ary = []
    @cart_items.each do |cart_item|
      ary << cart_item.item.price*cart_item.amount
    end
    @cart_items_price = ary.sum
      
    @total_price = @postage + @cart_items_price
    @address_type = params[:order][:address_type]
    case @address_type
    when "customer_address"
      @selected_address = current_customer.postal_code + current_customer.address + current_customer.first_name + current_customer.last_name
    when "registered_address"
      unless params[:order][:registered_address_id] == ""
        selected = Address.find(params[:order][:registered_address_id])
        @selected_address = selected.postal_code + selected.address + selected.name
      else
        render :new
      end
    when "new_address"
      unless params[:order][:new_postal_code] == "" && params[:order][:new_address] == "" && params[:order][:new_name] == ""
        @selected_address = params[:order][:new_postal_code] + params[:order][:new_address] + params[:order][:new_name]
      else
        render :new
      end
    end
  end
  
  def index
     @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end
  

  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

end
