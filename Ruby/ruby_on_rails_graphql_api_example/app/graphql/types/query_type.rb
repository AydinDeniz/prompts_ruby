
module Types
  class QueryType < Types::BaseObject
    field :movies, [Types::MovieType], null: false do
      argument :genre, String, required: false
      argument :page, Integer, required: false
      argument :per_page, Integer, required: false
    end

    def movies(genre: nil, page: 1, per_page: 10)
      movies = Movie.includes(:actors, :genre)
      movies = movies.joins(:genre).where(genres: { name: genre }) if genre.present?
      movies.page(page).per(per_page)
    end
  end
end
