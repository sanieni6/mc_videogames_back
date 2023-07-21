class VideogamesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @videogames = Videogame.all.order(id: :desc)
    render json: @videogames
  end

  def show
    @videogame = Videogame.find(params[:id])
    render json: @videogame
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Videogame not found' }, status: :not_found
  end

  def create
    if can?(:create, Videogame)
      @videogame = Videogame.new(videogame_params)
      if @videogame.save
        render json: @videogame
      else
        render json: { message: 'Unprocessable Entity' }, status: :unprocessable_entity
      end
    else
      render json: { message: 'You are not authorized to create a videogame.' }, status: :unauthorized
    end
  end

  def destroy
    if can?(:destroy, Videogame)
      @videogame = Videogame.find(params[:id])
      @videogame.reservation.destroy if @videogame.reservation.present?
      @videogame.destroy
      render json: { message: 'Videogame deleted.' }, status: :ok
    else
      render json: { message: 'You are not authorized to delete a videogame.' }, status: :unauthorized
    end
  end

  private

  def videogame_params
    params.require(:videogame).permit(:name, :description, :price_per_day, :photo)
  end
end
