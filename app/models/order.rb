class Order < ApplicationRecord
  belongs_to :customer
  has_many :cart_items
  has_many :order_details, dependent: :destroy
  
  before_validation :set_default_payment_method, on: :create
  
  enum payment_method: {クレジットカード:0, 銀行振込:1}
  
  enum status: {入金待ち:0, 入金確認:1, 製作中:2, 発送準備中:3, 発送済み:4}
  
  private
  
  def set_default_payment_method
    self.payment_method ||= 'クレジットカード'
  end
  
end
