class UserMailer < ActionMailer::Base
  default from: "notifications@incapacitationplan.com"

  def welcome_email(user)
    @user = user
    @url = "https://radiant-savannah-1679.herokuapp.com/login"
    mail(:to => user.email_address, :subject => "Welcome to IncapacitationPlan.com")
  end
end
