class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  enum payment_method: { credit_card: 0, bank: 1 }
  # enum status: { waiting: 0, confirmation: 1, making: 2, preparation: 3, send: 4 }
  
end
