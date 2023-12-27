class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @customer = current_customer
    @addresses = Address.all
    @address = Address.new
    if @address.save
      flash[:notice] = "You have created address successfully."
      redirect_to addresses_path
    else
      render :index
    end

  end
  
  def edit
    @customer = current_customer
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
    flash[:notice] = "You have updated customer successfully."
    redirect_to customer_path(@customer)
    else
    render :index
    end
  end
  # 
  private
  
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number)
  end
  
  # def address_params
  #   params.require(:addresses).permit(:postal_code, :address, :name)
  # end
  
end
