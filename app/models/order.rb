class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  # after_create :create_order_details
  
  before_validation :set_default_payment_method, on: :create
  before_validation :set_default_status, on: :create
  
  enum payment_method: {クレジットカード:0, 銀行振込:1}
  
  enum status: {入金待ち:0, 入金確認:1, 製作中:2, 発送準備中:3, 発送済み:4}
  
  private
  
  def set_default_payment_method
    self.payment_method ||= 'クレジットカード'
  end
  
  def set_default_status
    self.status ||= Order.stasuses['入金待ち']
  end
  
  def create_order_details
    cart_items.each do |cart_item|
      OrderDetail.create!(
        order_id: id,
        item_id: cart_item.item_id,
        price: cart_item.item.price,
        amount: cart_item.amount,
        making_status: status
      )
    end
  end
end
