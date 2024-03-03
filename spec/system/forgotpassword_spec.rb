
require 'rails_helper'
require 'email_spec/helpers'

RSpec.describe "Forgotpasswords", type: :system do
  include Rails.application.routes.url_helpers
  include EmailSpec::Helpers
  include EmailSpec::Matchers
  
  before do
    driven_by(:selenium, using: :chrome, screen_size: [1400,1400] )
  end

  it "allows users to send a password reset link and click on the link to reset their password" do
    visit sign_in_path
    click_on "Reset password"
    fill_in "user-email-reset", with: "test1@gmail.com"
    click_on "submit-password-reset"

    @to = "test1@gmail.com"
    @body = "<a href='/reset_password_confirm_path'>Reset password</a>"
    @email = Mail::Message.new(:to => @to, :from => "foo@bar.com", :body => @body)
    allow(self).to receive(:mailbox_for).with(@to).and_return([@email])

    expect(open_email(@to, :from => "foo@bar.com")).to eq(@email)
    # p 5
    expect do
      expect(self).to(receive(:visit).with('/reset_password_confirm_path'))
      visit_in_email("Reset password")
    end.not_to raise_error
    # p 6  
  end
end


# @to = "test1@gmail.com"
#     @body = "<a href='/hello'>Reset password</a>"
#     @email = Mail::Message.new(:to => @to, :from => "foo@bar.com", :body => @body)
#     allow(self).to receive(:mailbox_for).with(@to).and_return([@email])

#     expect(open_email(@to, :from => "foo@bar.com")).to eq(@email)
    
#     expect do
#       expect(self).to(receive(:visit).with('/hello'))
#       visit_in_email("Reset password")
#     end.not_to raise_error  