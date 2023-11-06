require "swagger_helper"

RSpec.describe "api/v1/houses", type: :request do
  path "/api/v1/houses" do
    get("list houses") do
      tags "Houses"
      produces "application/json"
      security [Bearer: []]

      response(200, "successful") do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              address: { type: :string },
              description: { type: :string },
              price_per_day: { type: :integer },
              image: { type: :string },
            },
          }

        run_test!
      end
    end

    post("create house") do
      tags "Houses"
      consumes "application/json"
      security [Bearer: []]
      parameter name: :house, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          address: { type: :string },
          description: { type: :string },
          price_per_day: { type: :integer },
          image: { type: :string },
        },
        required: %w[name address description price_per_day image],
      }

      response(201, "successful") do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            address: { type: :string },
            description: { type: :string },
            price_per_day: { type: :integer },
            image: { type: :string },
          }

        run_test!
      end

      response(422, "unprocessable entity") do
        schema type: :object,
          properties: {
            error: { type: :string },
          }

        run_test!
      end
    end
  end
end
