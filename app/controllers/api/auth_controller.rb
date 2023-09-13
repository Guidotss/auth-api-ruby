class Api::AuthController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    user_data = login_params
    @user = User.find_by_name(user_data[:name])
    if @user&.authenticate(user_data[:password])
      render json: {ok: true, user: @user.attributes.except('password_digest', 'password'), token:JsonWebToken.encode(user_id: @user.id)}
    else
      render json: { ok: false, message: 'Invalid credentials' }, status: :unauthorized
    end

  end

  def register

  end

  def revalidate
    @user = User.find(@decoded[:user_id])
    if @user
      render json: { ok:true, user: @user.attributes.except('password_digest', 'password'), token:JsonWebToken.encode(user_id: @user.id)}
    else
      render json: { ok: false, message: 'Invalid credentials' }, status: :unauthorized

    end
  end

  private
  def login_params
    json_data = request.body.read
    data = json_data.present? ? JSON.parse(json_data).symbolize_keys : {}
  end

  def register_params
    json_data = request.body.read
    data = json_data.present? ? JSON.parse(json_data).symbolize_keys : {}
  end

end
