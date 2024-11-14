
class OrdersController < ApplicationController
  def recent_orders
    @orders = Rails.cache.fetch("recent_orders", expires_in: 1.hour) do
      Order.recent
    end
    render json: @orders
  end
end
