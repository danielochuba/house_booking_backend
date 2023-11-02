class AddHouseNameToHouseBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :house_bookings, :house_name, :string
    add_column :house_bookings, :house_image, :string
  end
end
