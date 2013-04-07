class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all

    render json: @groups
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])

    render json: @group.to_json(:include => {:memberships => {:only => [:admin], :include => {:user => {:only => [:id, :first_name, :last_name, :email]}}}})
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    render json: @group
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(name: params[:group][:name], expiration: params[:group][:expiration])
    params[:group][:users].each do |u|
    	Membership.create(group: @group, user: User.where("id = ? OR email = ?", u[:id], u[:email]).first, admin:u[:admin])
    end

    if @group.save
      render json: @group, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    if @group.update_attributes(params[:group])
      head :no_content
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    head :no_content
  end
end
