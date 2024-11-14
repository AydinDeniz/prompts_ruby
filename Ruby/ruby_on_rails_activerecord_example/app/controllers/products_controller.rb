
class ProductsController < ApplicationController
  def index
    @products = Product.filtered_by_price(params[:min_price], params[:max_price]).top_selling.limit(10)
    render json: @products
  end
end
