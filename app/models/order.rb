class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  enum payment_method: { credit_card: 0, bank: 1 }
  # enum status: { waiting: 2, confirmation: 3, making: 4, preparation: 5, send: 6 }
  
end
