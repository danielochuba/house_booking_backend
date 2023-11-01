class Api::V1::HouseBookingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate

  def create
    @booking = HouseBooking.new(booking_params)
    if @booking.save
      render json: @booking, status: :created
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  def index
    return unless current_user

    @bookings = HouseBooking.where(user_id: current_user.id)
    render json: @bookings
  end

  private

  def booking_params
    house = House.find(params[:house_booking][:house_id])

    params.require(:house_booking).permit(
      :house_id,
      :number_of_days,
      :start_date
    ).merge(
      user_id: current_user.id,
      price: calculate_total_price(house)
    )
  end

  def calculate_total_price(house)
    days = params[:house_booking][:number_of_days].to_i
    price_per_day = house.price_per_day.to_i

    days * price_per_day
  end
end
