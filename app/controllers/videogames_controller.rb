class VideogamesController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

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
    if double_check_user_verification
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
    else
      render json: { message: 'You are not authorized to create a videogame.' }, status: :unauthorized
    end
  end

  def destroy
    if double_check_user_verification
      if can?(:destroy, Videogame)
        @videogame = Videogame.find(params[:id])
        @videogame.reservation.destroy if @videogame.reservation.present?
        @videogame.destroy
        render json: { message: 'Videogame deleted.' }, status: :ok
      else
        render json: { message: 'You are not authorized to delete a videogame.' }, status: :unauthorized
      end
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

  def double_check_user_verification
    return false if request.headers['Authorization'].nil?

    user = user_from_token
    return true if user_signed_in? && current_user.id == user.id

    false
  end
end
