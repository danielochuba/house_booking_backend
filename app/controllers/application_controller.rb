class ApplicationController < ActionController::Base
  def authenticate
    token = cookies[:token]
    if token
      decoded_token = decode_token(token)
      user_id = decoded_token[0]["user_id"]
      @current_user = User.find_by(id: user_id)
    end
  end

  def current_user
    @current_user
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)
  end
end
