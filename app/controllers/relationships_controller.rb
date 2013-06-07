class RelationshipsController < ApplicationController

  def index
        @user = User.find_by_id(session["user_id"])
    # if User.find_by_id(session["user_id"]).admin?
    # @relationships = Relationship.all
    # else
      @relationships = Relationship.find_all_by_principal_id(session["user_id"])
      # @custodians = User.find_by_id(@relationships.custodian_id)
    # end
  end

  def show
    @relationship = Relationship.find_by_id(params[:id])
    @user = User.find_by_id(session["user_id"])
  end

  def new
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
      @user.save(:validate => false)
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
      @email1 = User.find_by_id(@relationship.custodian_id).email_address
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
end
