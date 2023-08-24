class DirectorsController < ApplicationController
    # GET /directors
    def index
        @directors = Director.all
        render json: @directors
    end

    # POST /directors
    def create
        @director = Director.new(director_params)
        if @director.save
          render json: @director
        else
          render json: @director.errors, status: :unprocessable_entity
        end
    end

    # GET /directors/:id
    def show
        @director = Director.find(params[:id])
        render json: @director
    end

    # DELETE /directors/:id
    def destroy
        @director = Director.find(params[:id])
        @director.destroy
        render json: {}
    end

    # DELETE /directors
    def destroy_all
        Director.destroy_all
        render json: Director.all
    end

    # GET /directors/oscars
    def oscars
        @directors = Director.where(has_oscars: true)
        render json: @directors
    end

    private
    def director_params
        params.require(:director).permit(:name, :age, :country, :has_oscars)
    end
end
