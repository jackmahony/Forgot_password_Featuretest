require 'rails_helper'
require 'email_spec/helpers'

RSpec.describe "Forgotpasswords", type: :system do
  include Rails.application.routes.url_helpers
  include EmailSpec::Helpers

  before do
    driven_by(:selenium, using: :chrome, screen_size: [1400,1400])
  end

  it "sends a password reset email when user clicks 'Reset Password'" do
    visit sign_in_path
    click_on "Reset password"
    user = User.create(email: "test@example.com", password: "password123")
    fill_in "user-email-reset", with: user.email
    click_on "submit-password-reset"

    p 6

    # I'm really struggling to write this part of the test please help me better understand the email-spec gem as I've spent many hours trying to figure this out any assistance much appreciated!

    # @email = UserMailer.reset_password(user.email)
    expect(UserMailer).to(receive(:reset_password).with(user.email))
    p 7 
  end
end