class MembershipsController < ApplicationController
  before_filter :get_group_and_user

  def get_group_and_user
    @group = Group.find(params[:group_id])
    @user = User.find(params[:user_id])
  end

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = @group.memberships

    render json: @memberships
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
    @membership = @user.memberships.where("group_id = ?", @group.id).first

    render json: @membership
  end

  # GET /memberships/new
  # GET /memberships/new.json
  def new
    @membership = @group.memberships.build

    render json: @membership
  end

  # POST /memberships
  # POST /memberships.json
  def create
    logger.info "Post parameters memberships: #{params}"
    @membership = @group.memberships.create(user: @user, admin: params[:membership][:admin] )

    if @membership.save
      render json: @membership, status: :created, location: [@group, @membership]
    else
      render json: @membership.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    @membership = @group.memberships.find(params[:id])

    if @membership.update_attributes(params[:membership])
      head :no_content
    else
      render json: @membership.errors, status: :unprocessable_entity
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership = @user.memberships.where("group_id = ?", @group.id).first
    @membership.destroy

    head :no_content
  end
end
