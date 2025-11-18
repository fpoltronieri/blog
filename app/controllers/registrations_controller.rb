class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]
  before_action :redirect_if_authenticated, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path, notice: 'Registration successful.'
    else
      render :new, status: :unprocessable_entity, alert: 'Registration failed.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email_address, :password, :password_confirmation)
  end
end
