require 'swagger_helper'

RSpec.describe 'api/v1/authentication', type: :request do
  path '/api/v1/auth/login' do
    post('Login Authentication') do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
        },
        required: %w[username password]
      }

      response(200, 'Successful') do
        schema type: :object,
               properties: {
                 token: { type: :string }
               },
               required: ['token']

        let(:credentials) { { username: 'example_user', password: 'password123' } }
        run_test!
      end

      response(401, 'Unauthorized') do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: ['error']

        let(:credentials) { { username: 'invalid_user', password: 'incorrect_password' } }
        run_test!
      end
    end
  end

  path '/api/v1/auth/register' do
    post('Register Authentication') do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
        },
        required: %w[username password]
      }

      response(201, 'Created') do
        schema type: :object,
               properties: {
                 token: { type: :string }
               },
               required: ['token']

        let(:user) { { username: 'new_user', password: 'password123' } }
        run_test!
      end

      response(422, 'Unprocessable Entity') do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: ['error']

        let(:user) { { username: '', password: 'password123' } }
        run_test!
      end
    end
  end
end
