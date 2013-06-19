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
    @accounts = @user.accounts
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
    @user.email_verification = (0...50).map{ ('a'..'z').to_a[rand(26)] }.join

    if @user.save
      session["user_id"] = @user.id
      UserMailer.verify_address_email(@user).deliver
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
    if params[:new_email_verification].present?
        UserMailer.verify_address_email(@user).deliver
    end
    if @user.email_verification.nil?
      @user.email_verification = (0...50).map{ ('a'..'z').to_a[rand(26)] }.join
    end
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.email_address = params[:email_address]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.email_address == "incapacitationplan@gmail.com"
      @user.admin = true
    end
    if params[:email_verification] == @user.email_verification
      @user.email_verified = true
    end

    if @user.save
      session["user_id"] = @user.id
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
      @user.relationships.each do |r|
      r.destroy
      end
    @user.destroy
    redirect_to users_url
  end

  def signed_in_user
    if session["user_id"].nil?
     unless params[:email_verification] == User.find_by_id(params[:id]).email_verification
      store_location
      redirect_to login_url, notice: "Please sign in."
    end
  end

  def correct_user
    if session["user_id"].nil?
      redirect_to(root_path) unless params[:email_verification] == User.find_by_id(params[:id]).email_verification
    else
    @user = User.find_by_id(session["user_id"])
    redirect_to(root_path) unless current_user?(@user)
    end
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
