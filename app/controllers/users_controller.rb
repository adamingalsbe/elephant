class UsersController < ApplicationController
before_filter :signed_in_user, except: [:new, :create]
before_filter :correct_user, only: [:edit, :update, :show]
before_filter :admin, only: [:index, :destroy]

  def index
      @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    @banks = @user.banks
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
      session["user_id"] = @user.id
      redirect_to user_path
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
    @user.admin = params[:admin]


    if @user.save
      flash[:success] = "Profile updated"
      redirect_to user_url
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
      unless session["user_id"].present?
        # store_location
        redirect_to login_url, notice: "Please sign in."
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  end

  # def admin
  #   if User.find_by_id(session["user_id"]).admin.nil?
  #     redirect_to(root_path)
  #   end
  # end
end
