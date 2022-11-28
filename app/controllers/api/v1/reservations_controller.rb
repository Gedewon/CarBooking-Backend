class Api::V1::ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show update destroy]
  before_action :authenticate_user
  def index
    @reservation = Reservation.where(user: current_user)
    render json: @reservation
  end

  def show
    if @reservation
    render json: @reservation
    else 
    render json: {} , status: :not_found
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def update
    begin
      if @reservation.update(reservation_params)
        render json: @reservation
      else
        render json: @reservation.errors, status: :unprocessable_entity
      end
    rescue => exception
        render json:{} , status: :internal_server_error
    end
  end

  def destroy
    begin
      @reservation.destroy
    rescue => exception
      render json:{},status: :internal_server_error
    end
  end

  private

  def set_reservation
    begin
      @reservation = Reservation.find(params[:id])
    rescue => exception
      @reservation =nil
    end
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :city, :car_id)
  end
end
