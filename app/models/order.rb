class Order
  include Mongoid::Document
  field :name, type: String
  field :address, type: String
  field :email, type: String
  field :pay_type, type: String

  # TODO 使用中文赋值
  PAYMENT_TYPES = [ 'check', 'Credit card', 'purchase order' ]
end
