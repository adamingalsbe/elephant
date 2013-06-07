class RelationshipsController < ApplicationController

  def index
    @relationships = Relationship.all
  end

  def show
    @relationship = Relationship.find_by_id(params[:id])
  end

  def new
    @relationship = Relationship.new
  end

  def create
    @relationship = Relationship.new
    @relationship.principal_id = session["user_id"]
    if User.find_by_email_address(params[:custodian1_email_address].downcase).present?
      m = User.find_by_email_address(params[:custodian1_email_address].downcase)
      @relationship.custodian1_id = m.id
    else
      @user = User.new
      @user.email_address = params[:custodian1_email_address]
      @user.save(:validate => false)
    end
    # @relationship.custodian2_id = params[:custodian2_id]
    # @relationship.custodian3_id = params[:custodian3_id]

    if @relationship.save
      redirect_to relationships_url
    else
      render 'new'
    end
  end

  def edit
    @relationship = Relationship.find_by_id(params[:id])
    if User.find_by_id(@relationship.custodian1_id).present?
      @email1 = User.find_by_id(@relationship.custodian1_id).email_address
    end
    if User.find_by_id(@relationship.custodian2_id).present?
      @email2 = User.find_by_id(@relationship.custodian2_id).email_address
    end
    if User.find_by_id(@relationship.custodian3_id).present?
      @email3 = User.find_by_id(@relationship.custodian3_id).email_address
    end
  end

  def update
    @relationship = Relationship.find_by_id(params[:id])
    if User.find_by_email_address(params[:custodian1_email_address].downcase).present?
      m = User.find_by_email_address(params[:custodian1_email_address].downcase)
      @relationship.custodian1_id = m.id
    else
      @user = User.new
      @user.email_address = params[:custodian1_email_address]
      @user.save(:validate => false)
    end
    @relationship.custodian2_id = params[:custodian2_id]
    @relationship.custodian3_id = params[:custodian3_id]

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
