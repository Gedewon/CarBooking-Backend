class Api::V1::CarsController < ApplicationController
  before_action :set_car, only: %i[show update destroy]
  before_action :authenticate_user, only: %i[destroy update create]
  def index
    @cars = Car.where(rented: false)
    render json: @cars
  end

  def show
    if @car
      render json: @car
    else
      render json: {}, status: :not_found
    end
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      render json: @car, status: :created
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  def update
    if @car.update(car_params)
      render json: @car
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @car.destroy
  end

  private

  def set_car
    @car = Car.find(params[:id])
  rescue StandardError
    @car = nil
  end

  def car_params
    params.require(:car).permit(:name, :image, :amount, :brand, :car_type, :color, :rented)
  end
end
