
module Types
  class GenreType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :movies, [Types::MovieType], null: true
  end
end
