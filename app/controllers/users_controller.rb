class UsersController < ApplicationController
before_filter :signed_in_user, only: [:edit, :update]
# before_filter :correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.email_address = params[:email_address]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.email_address = params[:email_address]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    if @user.save
      flash[:success] = "Profile updated"
      redirect_to users_url
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect_to users_url
  end

  def signed_in_user
      redirect_to login_url, notice: "Please sign in." unless session["user_id"].present?
  end

  # def correct_user
  #   @user = User.find(params[:id])
  #   redirect_to(root_path) unless session["user_id"](@user)
  # end
end
