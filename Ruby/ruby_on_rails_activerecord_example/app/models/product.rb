
class Product < ApplicationRecord
  scope :filtered_by_price, -> (min_price, max_price) { where(price: min_price..max_price) if min_price && max_price }
  scope :top_selling, -> { order(sales_count: :desc) }
end
