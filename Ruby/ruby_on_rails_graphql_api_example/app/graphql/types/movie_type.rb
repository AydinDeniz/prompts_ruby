
module Types
  class MovieType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :release_year, Integer, null: true
    field :actors, [Types::ActorType], null: true
    field :genre, Types::GenreType, null: true
  end
end
