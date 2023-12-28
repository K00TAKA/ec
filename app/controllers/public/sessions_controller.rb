# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  # before_action :customer_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end


  
  private
  
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
  
  def customer_state
    # [処理内容1]　入力されたemailからアカウント1件取得
    customer = Customer.find_by(email: params[:customer][:email])
    # [処理内容2]　アカウントを取得できなかった場合、このメソッドを終了する
    return if customer.nil?
    # [処理内容3]　取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
    return unless customer.valid_password?(params[:customer][:password])
    # 【処理内容4】 アクティブでない会員に対する処理
    customer.update(is_deleted: true)
    # 今回、会員情報を削除せず、is_deletedを使ってステータス管理する（trueの時退会、falseの時未退会）
  end

end
