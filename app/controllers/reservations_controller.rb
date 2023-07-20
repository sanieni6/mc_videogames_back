class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(:videogame).order(:id => :desc)
    render json: @reservations, include: :videogame
  end

  def new
    @reservation = Reservation.new
  end

  def create
    if double_check_user_verification
      @videogame = Videogame.find(params[:reservation][:videogame_id])
      days = params[:reservation][:days].to_i
      total_price = @videogame.price_per_day * days

      @reservation = current_user.reservations.build(
        videogame_id: @videogame.id,
        days:,
        total_price:
      )

      if @reservation.save
        render json: @reservation, status: :created
      else
        render json: @reservation.errors, status: :unprocessable_entity
      end
    else
      render json: { message: 'You are not authorized to create a reservation.' }, status: :unauthorized
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:videogame_id, :days, :total_price)
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
