
require 'rails_helper'
require 'email_spec/helpers'

RSpec.describe "Forgotpasswords", type: :system do
  include Rails.application.routes.url_helpers
  include EmailSpec::Helpers
  include EmailSpec::Matchers
  
  before do
    driven_by(:selenium, using: :chrome, screen_size: [1400,1400] )
  end

  it "allows users to send a password reset link" do
    visit sign_in_path
    click_on "Reset password"
    fill_in "user-email-reset", with: "test1@gmail.com"
    click_on "submit-password-reset"

    # Send UserMailer.reset_password.deliver_now
    # @email = UserMailer.reset_password("test1@gmail.com").deliver_now
    expect(last_email_sent).to have_subject("Password reset")
  end  

end
