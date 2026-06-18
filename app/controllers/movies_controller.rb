class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # GET /movies or /movies.json
  def index
    require "net/http"
    require "json"

    api_key = ENV["TMDB_API_KEY"]
    uri = URI("https://api.themoviedb.org/3/movie/popular")
    uri.query = URI.encode_www_form(api_key: api_key)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.get(uri.request_uri)
    @show_movies_tmdb_db = JSON.parse(response.body)["results"]  # fetches popular movies from TMDB
  end

  # GET /movies/1 or /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
    @movie.title = params[:title] if params[:title]
    @movie.review = params[:review] if params[:review]
    @movie.genre = params[:genre] if params[:genre]
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @movie.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: "Movie was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @movie.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy!

    respond_to do |format|
      format.html { redirect_to movies_path, notice: "Movie was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end



 # GET /search_tmdb
def search_tmdb
  require "net/http"
  require "json"

  query = params[:query]
  api_key = ENV["TMDB_API_KEY"]
  uri = URI("https://api.themoviedb.org/3/search/movie")
  uri.query = URI.encode_www_form(api_key: api_key, query: query)

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  response = http.get(uri.request_uri)
  @results = JSON.parse(response.body)["results"]

  render :search_tmdb
end


  private

    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.expect(movie: [ :title, :genre, :rating, :review, :watched ])
    end
end