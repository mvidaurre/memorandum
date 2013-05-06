class UsersController < ApplicationController
  #skip_before_filter :require_api_token, :only => [:new, :create, :login]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    if @user.save
      render json: @user, status: :created, location: @user
    else
      logger.info "User create errors: #{@user.errors{|e| e.to_json}}"
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if authorized_user?
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        head :no_content
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: {error: "YOU CAN ONLY UPDATE YOUR OWN USER DATA"}, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if authorized_user?
      @user = User.find(params[:id])
      @user.destroy
      head :no_content
    else
      render json: {error: "YOU CAN ONLY DESTROY YOUR OWN USER"}, status: :unprocessable_entity
    end
  end

  # POST /users/login
  def login
    @user = User.where(email: params[:user][:email], password: params[:user][:password]).first
    unless @user.nil?
      #logger.info "User: #{@user.email} for these params: #{params}" 
      render json: @user
    else
      render json: {error: "USER NOT FOUND OR INCORRECT PASSWORD"}
    end  

  end
end
