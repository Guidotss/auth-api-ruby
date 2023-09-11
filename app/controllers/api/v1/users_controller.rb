class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
    if @users
      render json: {ok: true, users: @users}, status: :ok
    else
      render json: { ok: false, message: 'No users found' }, status: :not_found
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save

      render json: { ok: true, user: @user.attributes.except('password', 'password_digest')}, status: :created
    else
      render json: { ok: false, message: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private
  def user_params
    JSON.parse(request.body.read).symbolize_keys
  end
end
