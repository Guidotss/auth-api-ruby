class Api::UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  def index
    @users = User.all
    if @users.present?

      users_to_show = @users.map do |user|
        user.attributes.except('password', 'password_digest')
      end

      render json: {ok: true, users: users_to_show}, status: :ok
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
