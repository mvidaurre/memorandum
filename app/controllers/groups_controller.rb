class GroupsController < ApplicationController
  before_filter :get_membership, :only => [:show, :index, :update, :destroy] 

  # GET /groups
  # GET /groups.json
  def index
    @groups = current_user.groups
    render json: @groups
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    #logger.info "GroupsController Get Parameters: #{params}"
    if @group
      render json: @group.to_json(:include => {:memberships => {:only => [:admin], :include => {:user => {:only => [:id, :first_name, :last_name, :email]}}}})
    else
      render json: {error: "YOU MUST BE MEMBER OF THIS GROUP TO SEE IT"}, status: :unprocessable_entity
    end
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
    #logger.info "Post parameters: #{params}"
    @group = Group.new(name: params[:group][:name], expiration: params[:group][:expiration])
    if @group.save
      params[:group][:users].each do |u|
        @group.memberships.create(user: User.where("id = ? OR email = ?", u[:id], u[:email]).first, admin:u[:admin])
      end
      render json: @group, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    #logger.info "Put parameters: #{params.to_json}"

    if @membership.admin 
      if @group.update_attributes(params[:group])
        head :no_content
      else
        render json: @group.errors, status: :unprocessable_entity
      end
    else 
       render json: {error: "YOU MUST BE AN ADMINISTRATOR TO COMPLETE THIS ACTION"}, status: :unprocessable_entity
    end 
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    if @membership.admin 
      @group.destroy
    else
       render json: {error: "YOU MUST BE AN ADMINISTRATOR TO COMPLETE THIS ACTION"}, status: :unprocessable_entity
    end 
    head :no_content
  end

  private

  def get_membership
    if params[:group_id] || params[:id]
      id = params[:group_id] || params[:id]
      @group = Group.find(id)
      @membership = current_user.memberships.where("group_id = ?", @group.id).first
      @group = nil if @membership.nil?
    end
  end
end
