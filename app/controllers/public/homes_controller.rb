class Public::HomesController < ApplicationController
  before_action :authenticate_customer!
  
  def top
    @genres = Genre.all
  end
  
  def about
    
  end
end
