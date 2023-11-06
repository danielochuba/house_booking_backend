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

  path "/api/v1/houses/{id}" do
    parameter name: "id", in: :path, type: :string, description: "House ID"

    get("show house") do
      tags "Houses"
      security [Bearer: []]

      response(200, "successful") do
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
    end

    delete("delete house") do
      tags "Houses"
      security [Bearer: []]

      response(200, "successful") do
        schema type: :object,
          properties: {
            message: { type: :string },
          }

        run_test!
      end
    end
  end

  path "/api/v1/houses/find_by_name" do
    get("find_by_name house") do
      tags "Houses"
      security [Bearer: []]
      parameter name: :name, in: :query, type: :string, required: true, description: "House name"

      response(200, "successful") do
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
    end
  end
end
