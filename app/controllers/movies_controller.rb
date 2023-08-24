class MoviesController < ApplicationController
    def create
        @director = Director.find(params[:director_id])
        @movie = @director.movies.create(movie_params)
        if @movie.save
            render json: @movie
        else
            render json: @movie.errors, status: :unprocessable_entity
        end
    end

    def index
        @director = Director.find(params[:director_id])
        @movies = @director.movies
        render json: @movies
    end

    def update
        @director = Director.find(params[:director_id])
        @movie = @director.movies.find(params[:movie_id])
        if @movie.update(movie_params)
          render json: @movie
        else
          render json: @movie.errors, status: :unprocessable_entity
        end
    end

    def search
        # https://stackoverflow.com/questions/19777720/rails-sql-regular-expression
        @movies = Movie.where("sinopsis LIKE ?", "%#{params[:keyword]}%")
        render json: @movies
    end

    private
        def movie_params
            params.require(:movie).permit(:title, :sinopsis, :duration, :premiere)
        end
end
