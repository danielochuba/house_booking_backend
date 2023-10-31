class Api::V1::HousesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate
  def index
    @houses = House.all
    render json: @houses
  end
  def create
    house = House.new(house_params)

    if house.save
      render json: house, status: :created
    else
      render json: house.errors, status: :unprocessable_entity
    end
  end

  private

  def house_params
    params.require(:house).permit(:name, :address, :description, :price_per_day, :image).merge(user_id: current_user.id)
  end
end
