class CreateHouseBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :house_bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :house, null: false, foreign_key: true
      t.integer :number_of_days
      t.float :price
      t.date :start_date

      t.timestamps
    end
  end
end
