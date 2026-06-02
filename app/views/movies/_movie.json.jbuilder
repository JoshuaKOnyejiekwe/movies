json.extract! movie, :id, :title, :genre, :rating, :review, :watched, :created_at, :updated_at
json.url movie_url(movie, format: :json)
