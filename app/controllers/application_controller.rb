class ApplicationController < ActionController::Base
  def authenticate
    token = request.headers['Authorization']
    return unless token

    token = token.split[1]

    decoded_token = decode_token(token)
    user_id = decoded_token[0]['user_id']
    @current_user = User.find_by(id: user_id)
  end

  attr_reader :current_user

  def decode_token(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)
  end
end
