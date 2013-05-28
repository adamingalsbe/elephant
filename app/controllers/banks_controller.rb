class BanksController < ApplicationController
before_filter :signed_in_user
before_filter :correct_user, only: [:edit, :show, :update, :destroy]
# before_filter :admin, only: [:index]

  def index
    @banks = Bank.all
  end

  def show
    @bank = Bank.find_by_id(params[:id])
  end

  def new
    @bank = Bank.new
  end

  def create
    @bank = Bank.new
    @bank.name = params[:name]
    @bank.notes = params[:notes]
    @bank.user_id = session["user_id"]

    if @bank.save
      redirect_to "/users/#{session["user_id"]}"
    else
      render 'new'
    end
  end

  def edit
    @bank = Bank.find_by_id(params[:id])
  end

  def update
    @bank = Bank.find_by_id(params[:id])
    @bank.name = params[:name]
    @bank.notes = params[:notes]
    @bank.user_id = params[:user_id]

    if @bank.save
      redirect_to "/users/#{session["user_id"]}"
    else
      render 'new'
    end
  end

  def destroy
    @bank = Bank.find_by_id(params[:id])
    @bank.destroy
    redirect_to banks_url
  end

  def signed_in_user
      redirect_to login_url, notice: "Please sign in." unless session["user_id"].present?
  end

  def correct_user
    @bank = Bank.find_by_id(params[:id])
    @user = User.find_by_id(@bank["user_id"])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin
    if User.find_by_id(session["user_id"]).admin.nil?
      redirect_to(root_path)
    end
  end
end
