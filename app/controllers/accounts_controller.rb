class AccountsController < ApplicationController
before_filter :signed_in_user
before_filter :correct_user, only: [:edit, :show, :update, :destroy]
# before_filter :admin, only: [:index]

  def index
    @user = User.find_by_id(session["user_id"])
    if User.find_by_id(session["user_id"]).admin?
      @accounts = Account.all
    else
      @accounts = Account.find_all_by_user_id(session["user_id"])
    end
  end

  def show
    @account = Account.find_by_id(params[:id])
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new
    @account.name = params[:name]
    @account.notes = params[:notes]
    @account.user_id = session["user_id"]

    if @account.save
      redirect_to "/users/#{session["user_id"]}"
    else
      render 'new'
    end
  end

  def edit
    @account = Account.find_by_id(params[:id])
  end

  def update
    @account = Account.find_by_id(params[:id])
    @account.name = params[:name]
    @account.notes = params[:notes]


    if @account.save
      redirect_to "/users/#{session["user_id"]}"
    else
      render 'new'
    end
  end

  def destroy
    @account = Account.find_by_id(params[:id])
    @account.destroy
    redirect_to accounts_url
  end

  def signed_in_user
      redirect_to login_url, notice: "Please sign in." unless session["user_id"].present?
  end

  def correct_user
    @account = Account.find_by_id(params[:id])
    @user = User.find_by_id(@account["user_id"])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin
    if User.find_by_id(session["user_id"]).admin.nil?
      redirect_to(root_path)
    end
  end
end
