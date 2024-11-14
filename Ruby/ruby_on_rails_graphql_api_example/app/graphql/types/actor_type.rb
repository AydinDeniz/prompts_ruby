
module Types
  class ActorType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :movies, [Types::MovieType], null: true
  end
end
