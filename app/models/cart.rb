class Cart
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :line_items, :dependent => :destroy

  def add_product(product_id)
    current_item = self.line_items.where(product_id: product_id).first
    if current_item != nil
      current_item.quantity += 1
    else
      current_item = line_items.new product_id: product_id
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def total_items
    line_items.sum(:quantity)
  end
end
