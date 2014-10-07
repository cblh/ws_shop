class StoreController < ApplicationController
  def index
    @products = Product.paginate(page: params[:page], order: 'created_at_desc', per_page: 10)
    @cart = current_cart
  end
end
