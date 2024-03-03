class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def reset_password
        @user = params[:user]
        @token = @user.signed_id(purpose:"reset password", expires_in: 15.minutes)
        @url  = 'http://example.com/login'
        mail(to: @user.email, subject: 'Password reset')
    end
end
