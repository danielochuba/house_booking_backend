class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :verify_authenticity_token

  def login
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      token = encode_token(user.id)
      render json: { token: }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def register
    user = User.new(username: params[:username], password: params[:password])

    if user.save
      token = encode_token(user.id)
      render json: { token: }, status: :created
    else
      render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def encode_token(user_id)
    payload = { user_id: }
    token = JWT.encode(payload, Rails.application.secrets.secret_key_base)
    response.headers['Authorization'] = "Bearer #{token}"
    token
  end
end
