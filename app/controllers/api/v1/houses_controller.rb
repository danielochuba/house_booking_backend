class Api::V1::HousesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate

  def index
    @houses = House.all
    render json: @houses
  end

  def show
    house = House.find(params[:id])
    if house
      render json: house, status: :ok
    else
      render json: house.errors, status: :unprocessable_entity
    end
  end

  def create
    house = House.new(house_params)

    if house.save
      render json: house, status: :created
    else
      render json: house.errors, status: :unprocessable_entity
    end
  end

  def delete_houses
    @houses = House.where(user_id: current_user.id)

    render json: @houses, status: :ok
  end

  def destroy
    house = House.find_by(id: params[:id])

    if house
      @house_bookings = HouseBooking.where(house_id: house.id)
      @house_bookings.destroy_all

      if house.destroy
        render json: { message: "House deleted successfully" }
      else
        render json: { error: "Failed to delete the house" }, status: :unprocessable_entity
      end
    else
      render json: { error: "House not found" }, status: :not_found
    end
  end

  def find_by_name
    house = House.find_by(name: params[:name])

    if house
      render json: house, status: :ok
    else
      render json: { error: "House not found" }, status: :not_found
    end
  end

  private

  def house_params
    params.require(:house).permit(:name, :address, :description, :price_per_day, :image).merge(user_id: current_user.id)
  end
end
