
class MovieDatabaseSchema < GraphQL::Schema
  query(Types::QueryType)

  # Enable pagination for all connections
  default_max_page_size 20
end
