class StaticPagesController < ApplicationController
  def home
    if session["user_id"].present?
    redirect_to "/users/#{session["user_id"]}"
    end
  end

  def about
  end

  def help
  end

  def contact
  end

end
