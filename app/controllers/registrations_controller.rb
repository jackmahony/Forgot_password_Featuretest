class RegistrationsController < ApplicationController
  # layout "auth"

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)

    if @user.save
      flash[:notice] = "Welcome #{@user.email}"
      redirect_to home_path
    end
  end

  private

    def create_params
      params.require(:user).permit(:email, :password)
    end
end
