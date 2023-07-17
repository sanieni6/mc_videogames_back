class VideogamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @videogames = Videogame.all
    render json: @videogames
  end

  def show
    @videogame = Videogame.find(params[:id])
    render json: @videogame
  end

  def new
    @videogame = Videogame.new
  end

  def create
    user_from_token
    if can?(:create, Videogame)
      @videogame = Videogame.new(videogame_params)
      if @videogame.save
        render json: @videogame
      else
        render json: @videogame.errors, status: :unprocessable_entity
      end
    else
      render json: { message: 'You are not authorized to create a videogame.' }, status: :unauthorized
    end
  end

  def destroy
    user_from_token
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

  def user_from_token
    jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                             Rails.application.credentials.devise[:jwt_secret_key]).first
    user_id = jwt_payload['sub']
    User.find(user_id.to_s)
  end
end
