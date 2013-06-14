class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email_address(params[:email_address].downcase)
    if user && user.authenticate(params[:password])
      session["user_id"] = user.id
      redirect_back_or user
      else
      redirect_to "/login", notice: "Invalid email address or password."
    end
  end

  def destroy
    session["user_id"] = nil
    redirect_to "/", notice: "Come back soon!"
  end
end
