class Api::V1::HouseBookingsController < ApplicationController
  def create
    @booking = HouseBooking.new(booking_params)

    if @booking.save
      render json: @booking, status: :created
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  def index
    if current_user
    @bookings = HouseBooking.where(user_id: current_user.id)
    render json: @bookings
    else
      @bookings = HouseBooking.all
      render json: @bookings
    end
  end

  private

  def booking_params
    params.require(:house_booking).permit(:user_id, :house_id, :number_of_days, :price, :start_date)
  end
end
