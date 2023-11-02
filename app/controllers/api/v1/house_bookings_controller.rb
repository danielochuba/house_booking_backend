class Api::V1::HouseBookingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  def create
    @booking = HouseBooking.new(booking_params)

    if @booking.save
      render json: @booking, status: :created
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  def index
    user_id = current_user.id

    @houses_with_bookings = House.joins(:house_bookings)
                                 .where('house_bookings.user_id' => user_id)
                                 .select('houses.*, house_bookings.*')

    render json: @houses_with_bookings
  end

  private

  def booking_params
    params.require(:house_booking).permit(:user_id, :house_id, :number_of_days, :price, :start_date)
  end
end
