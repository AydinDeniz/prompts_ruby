
class Movie < ApplicationRecord
  belongs_to :genre
  has_many :movie_actors
  has_many :actors, through: :movie_actors

  validates :title, presence: true
  validates :release_year, numericality: { only_integer: true }, allow_nil: true
end
