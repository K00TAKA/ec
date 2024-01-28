class ApplicationController < ActionController::Base
  
  def after_sign_in_path_for(resource)
    if customer_signed_in?
      customers_path(current_customer)
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      admin_session_path
    else 
      root_path
    end
  end
  
end
