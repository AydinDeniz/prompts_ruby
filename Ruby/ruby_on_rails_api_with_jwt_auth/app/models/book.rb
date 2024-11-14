
class Book < ApplicationRecord
  validates :title, :author, :category, presence: true
end
