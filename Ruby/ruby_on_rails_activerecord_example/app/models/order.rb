
class Order < ApplicationRecord
  scope :recent, -> { where('created_at >= ?', 30.days.ago) }
end
