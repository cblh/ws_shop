class LineItem
  include Mongoid::Document
  include Mongoid::Timestamps
  field :quantity, type: Integer, default: 1

  belongs_to :order
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price * quantity
  end
end
