class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.all
    render json: @reservations
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @videogame = Videogame.find(params[:reservation][:videogame_id])
    days = params[:reservation][:days].to_i
    total_price = @videogame.price_per_day * days

    @reservation = current_user.reservations.build(
      videogame_id: @videogame.id,
      days: days,
      total_price: total_price
    )

    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def show
    @user_reservations = current_user.reservations
    render json: @user_reservations
  end

  private

  def reservation_params
    params.require(:reservation).permit(:videogame_id, :days, :total_price)
  end
end