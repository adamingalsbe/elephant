class RelationshipsController < ApplicationController
before_filter :signed_in_user
before_filter :correct_user, only: [:edit, :show, :update, :destroy]

  def index
        @user = User.find_by_id(session["user_id"])
    # if User.find_by_id(session["user_id"]).admin?
    # @relationships = Relationship.all
    # else
      @principal_relationships = Relationship.find_all_by_principal_id(session["user_id"])
      @custodian_relationships = Relationship.find_all_by_custodian_id(session["user_id"])
      # @custodians = User.find_by_id(@relationships.custodian_id)
    # end
  end

  def show
    @relationship = Relationship.find_by_id(params[:id])
    @user = User.find_by_id(session["user_id"])
  end

  def new
    @user = User.find_by_id(session["user_id"])
    @relationship = Relationship.new
  end

  def create
    @relationship = Relationship.new
    @relationship.principal_id = session["user_id"]
    if User.find_by_email_address(params[:custodian_email_address].downcase).present?
      m = User.find_by_email_address(params[:custodian_email_address].downcase)
      @relationship.custodian_id = m.id
    else
      @user = User.new
      @user.email_address = params[:custodian_email_address]
      @user.first_name = params[:custodian_first_name]
      @user.email_verification = (0...50).map{ ('a'..'z').to_a[rand(26)] }.join
      @user.referred_by = session["user_id"]
      @user.save(:validate => false)
      UserMailer.helper_verify_address_email(@user).deliver
      @relationship.custodian_id = @user.id
    end

    if @relationship.save
      redirect_to relationships_url
    else
      render 'new'
    end
  end

  def edit
    @relationship = Relationship.find_by_id(params[:id])
    if User.find_by_id(@relationship.custodian_id).present?
      @email = User.find_by_id(@relationship.custodian_id).email_address
    end
  end

  def update
    @relationship = Relationship.find_by_id(params[:id])
    if User.find_by_email_address(params[:custodian_email_address].downcase).present?
      m = User.find_by_email_address(params[:custodian_email_address].downcase)
      @relationship.custodian_id = m.id
    else
      @user = User.new
      @user.email_address = params[:custodian_email_address]
      @user.save(:validate => false)
    end

    if @relationship.save
      redirect_to relationships_url
    else
      render 'new'
    end
  end

  def destroy
    @relationship = Relationship.find_by_id(params[:id])
    @relationship.destroy
    redirect_to relationships_url
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

end
