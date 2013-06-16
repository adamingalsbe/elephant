class UserMailer < ActionMailer::Base
  default from: "notifications@incapacitationplan.com"

  def helper_verify_address_email(user)
    @user = user
    @principal = User.find_by_id(@user.referred_by)
    @url = "https://incapacitationplan.herokuapp.com/users/#{@user.id}/edit?email_verification=#{@user.email_verification}"
    mail(:to => user.email_address, :subject => "Please confirm your email address")
  end

  def verify_address_email(user)
    @user = user
    @url = "https://incapacitationplan.herokuapp.com/users/#{@user.id}/edit?email_verification=#{@user.email_verification}"
    mail(:to => user.email_address, :subject => "Please confirm your email address")
  end
end
