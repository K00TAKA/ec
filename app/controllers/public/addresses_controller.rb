class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @customer = current_customer
    @addresses = Address.all
  end
  
  def new
    @address = Address.new
  end
  
  def create
    @address = Address.new(address_params)
    if @address.save
      flash[:notice] = "You have created address successfully."
      redirect_to addresses_path
    else
      render :index
    end
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
    flash[:notice] = "You have updated address successfully."
    redirect_to addresses_path
    else
    render :edit
    end
  end
  # 
  private
  
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number)
  end
  
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
  
  # def address_params
  #   params.require(:addresses).permit(:postal_code, :address, :name)
  # end
  
end
