class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    track_index_settings()
    @all_ratings = Movie.get_all_ratings()
    ratings = params[:ratings]
    sort = params[:sort]
    @ratings_filter = get_ratings_filter(ratings)
    @title_selected = sort == 'title'
    @release_date_selected = sort == 'release_date'
    @movies = Movie.filter_by_rating(@ratings_filter).order(sort)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private

  def get_ratings_filter(ratings)
    filter = Array.new()
    ratings&.each_key {|rating| filter.push(rating)}
    filter
  end

  def track_index_settings
    session[:ratings] ||= {:G => 1, :PG => 1, :'PG-13' => 1, :R => 1}
    unless params[:ratings] == session[:ratings] && params[:sort] == session[:sort]
      params[:ratings] ||= session[:ratings]
      params[:sort] ||= session[:sort]
      flash.keep
      redirect_to movies_path(:ratings => params[:ratings], :sort => params[:sort])
    end
    session[:ratings] = params[:ratings]
    session[:sort] = params[:sort]
  end

end
