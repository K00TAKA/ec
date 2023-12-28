class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @customer = current_customer
  end
  
  def check
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def update
    @customer = current_customer
    if current_customer.update(customer_params)
    flash[:notice] = "You have updated customer successfully."
    redirect_to customers_path(@customer)
    else
    render :edit
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:is_deleted)
  end

end
