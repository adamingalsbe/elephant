class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email_address(params[:email_address].downcase)
    if user && user.authenticate(params[:password])
      session["user_id"] = user.id
      redirect_to user, notice: "Welcome back, #{user.first_name}"
      else
      redirect_to "/login", notice: "Invalid email address or password."
  end

  def destroy
    session["user_id'"] = nil
    redirect_to "/", notice: "Come back soon!"
  end
end
end