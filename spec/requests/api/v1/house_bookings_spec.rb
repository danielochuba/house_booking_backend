require 'swagger_helper'

RSpec.describe 'api/v1/house_bookings', type: :request do
  path '/api/v1/reservations' do
    post('create house_booking') do
      tags 'HouseBookings'
      consumes 'application/json'
      security [Bearer: []]
      parameter name: :house_booking, in: :body, schema: {
        type: :object,
        properties: {
          house_id: { type: :integer },
          number_of_days: { type: :integer },
          start_date: { type: :string, format: :date },
          house_name: { type: :string },
          house_image: { type: :string }
        },
        required: %w[house_id number_of_days start_date]
      }

      response(201, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 house_id: { type: :integer },
                 number_of_days: { type: :integer },
                 price: { type: :number },
                 start_date: { type: :string, format: :date }
               }

        run_test!
      end

      response(422, 'unprocessable entity') do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        run_test!
      end
    end
    get('list house_bookings') do
      tags 'HouseBookings'
      security [Bearer: []]

      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   user_id: { type: :integer },
                   house_id: { type: :integer },
                   number_of_days: { type: :integer },
                   price: { type: :number },
                   start_date: { type: :string, format: :date }
                 }
               }

        run_test!
      end
    end
  end
end
