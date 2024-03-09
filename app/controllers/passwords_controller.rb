class PasswordsController < ApplicationController

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

    def edit
      @user = User.find_signed!(params[:token], purpose: "reset password")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to sign_in_path, alert:"Your token has expired please try again"
    end

    def update
      @user = User.find_signed!(params[:token], purpose: "reset password")
      if @user.update(password_params) 
        redirect_to sign_in_path, notice: "Your password has been reset. Please sign in."
      else
        render :edit
      end  
    end 
    
    private

    def password_params
      params.require(:user).permit(:password)
    end  
  end
