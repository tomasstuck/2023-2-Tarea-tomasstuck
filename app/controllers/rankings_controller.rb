class RankingsController < ApplicationController
    def create
        @director = Director.find(params[:director_id])
        @ranking = @director.rankings.create(ranking_params)
        if @ranking.save
            render json: @ranking
        else
            render json: @ranking.errors, status: :unprocessable_entity
        end
    end

    def index
        @director = Director.find(params[:director_id])
        @rankings = @director.rankings
        render json: @rankings
    end

    def top
        # https://api.rubyonrails.org/classes/Arel.html
        sort = Arel.sql("(score - min_score) / (max_score - min_score) DESC")
        @rankings = Ranking.order(sort).limit(params[:quantity])
        render json: @rankings
    end

    def show_from_movie
        @movie = Movie.find(params[:movie_id])
        @director = @movie.director
        @rankings = @director.rankings
        render json: @rankings
    end

    def destroy_low
        sort = Arel.sql("(score - min_score) / (max_score - min_score) ASC")
        @ranking = Ranking.order(sort).first
        @director = @ranking.director
        @director.destroy
        render json: @director
    end

    def show
        # https://stackoverflow.com/questions/38793739/how-to-render-two-json-objects-as-response-on-a-rails-controller
        sort = Arel.sql("(score - min_score) / (max_score - min_score) DESC")
        @imdb = Ranking.where(page: "imdb").order(sort)
        @rotten_tomatoes = Ranking.where(page: "rotten_tomatoes").order(sort)
        @metacritic = Ranking.where(page: "metacritic").order(sort)
        render json: {imdb: @imdb, metacritic: @metacritic, rotten_tomatoes: @rotten_tomatoes,}
    end


    private
        def ranking_params
            params.require(:ranking).permit(:page, :min_score, :score, :max_score)
        end
end
