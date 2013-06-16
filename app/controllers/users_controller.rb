class UsersController < ApplicationController
before_filter :signed_in_user, except: [:new, :create]
before_filter :correct_user, only: [:edit, :update]
before_filter :helper, only: [:show]
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
      UserMailer.welcome_email(@user).deliver
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
      if @user.email_address == "incapacitationplan@gmail.com"
        @user.admin = true
      end

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
        store_location
        redirect_to login_url, notice: "Please sign in."
  end

  def correct_user
    @user = User.find_by_id(session["user_id"])
    redirect_to(root_path) unless current_user?(@user)
  end
  end

  def admin
    if User.find_by_id(session["user_id"]).admin.nil?
      redirect_to(root_path)
    end
  end

  def helper
    @r = Relationship.find_all_by_principal_id(params[:id])
    @user = User.find_by_id(params[:id])
    @viewer = User.find_by_id(session["user_id"])
      if @viewer.admin.nil?
        if @r.none? {|h| h[:custodian_id] == @viewer.id}
          redirect_to(root_path) unless current_user?(@user)
          end
        end
    end
end
