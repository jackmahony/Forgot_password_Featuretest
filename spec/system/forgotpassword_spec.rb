require 'rails_helper'
require 'email_spec/helpers'

RSpec.describe "Forgotpasswords", type: :system do
  include Rails.application.routes.url_helpers
  include EmailSpec::Helpers
  include ActiveJob::TestHelper

  before do
    driven_by(:selenium, using: :chrome, screen_size: [1400,1400])
  end
 
  it "sends a password reset email when user clicks 'Reset Password' and allows the user to set a new password and then log in with the new password" do
    perform_enqueued_jobs do
      visit sign_in_path
      click_on "Reset password"
      user = User.create(email: "testuser@example.com", password: "password123")
      fill_in "user-email-reset", with: user.email
      click_on "submit-password-reset"

      expect(page).to have_content("Check your email for a link to reset your password.")
      ActionMailer::Base.deliveries
      open_last_email
      click_email_link_matching(/reset_password/)
    
      fill_in "new-password", with: "new password"

      visit sign_in_path
      fill_in "user-email", with: "testuser@example.com"
      
      fill_in "user-password", with: "password123"
      click_on "user-login-submit"
      
    end  
  end
end