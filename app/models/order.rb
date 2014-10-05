class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :address, type: String
  field :email, type: String
  field :pay_type, type: String

  has_many :line_items, dependent: :destroy

  # TODO 使用中文赋值
  PAYMENT_TYPES = [ 'check', 'Credit card', 'purchase order' ]

  validates :name, :address, :email, :pay_type, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  def add_line_items_from_cart cart
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
      item.save
    end
  end
end
