class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @customers = Customer.all
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  # private
  # def customer_params
  #   params.require(:customer).permit(:)
  # end
  
end
