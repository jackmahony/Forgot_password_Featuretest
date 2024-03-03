class SessionsController < ApplicationController
  def destroy

  end

  def create
    if user
      flash[:notice] = "Welcome #{user.email}"
      redirect_to home_path
    else
      # Handle unsuccessful authentication (e.g., display an error message)
      flash[:alert] = "Invalid email or password"
      render :new
    end
  end

  private

    def user
      User.find_by(email: params[:email])
        &.authenticate(params[:password])
    end
end
