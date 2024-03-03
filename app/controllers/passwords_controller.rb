class PasswordsController < ApplicationController
    def edit
    end
    
    def new
      @user = User.new
    end

    def create
      @user = User.find_by(email: params[:email])
      if @user.present?
        UserMailer.with(user: @user).reset_password.deliver_now
        redirect_to password_reset_confirmation_path, notice: "Check your email for a link."
      else
        flash[:alert] = "Email address not found."
        redirect_to root_path
      end
    end
    
    def confirmation
    end  

    def update

    end  
  end