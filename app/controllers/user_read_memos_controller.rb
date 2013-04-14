class UserReadMemosController < ApplicationController
  # GET /user_read_memos
  # GET /user_read_memos.json
  before_filter :get_user_and_group_and_memo

  def get_user_and_group_and_memo
    @group = Group.find(params[:group_id])
    @user = User.find(params[:user_id])
    @memo = Memo.find(params[:memo_id])
  end

  def index
    @user_read_memos = @memo.user_read_memos
    
    render json: @user_read_memos
  end

  # GET /user_read_memos/1
  # GET /user_read_memos/1.json
  def show
    @user_read_memo = @memo.user_read_memos.find(params[:id])
    
    render json: @user_read_memo
  end

  # GET /user_read_memos/new
  # GET /user_read_memos/new.json
  def new
    @user_read_memo = @memo.user_read_memos.build
   
    render json: @user_read_memo
  end

  # POST /user_read_memos
  # POST /user_read_memos.json
  def create
    @user_read_memo = @memo.user_read_memos.new(params[:user_read_memo])

    if @user_read_memo.save
      render json: [@user, @group, @memo, @user_read_memo], status: :created, location: [@user, @group, @memo, @user_read_memo]
    else
      render json: @user_read_memo.errors, status: :unprocessable_entity
    end
 end

  # PATCH/PUT /user_read_memos/1
  # PATCH/PUT /user_read_memos/1.json
  def update
    @user_read_memo = @memo.user_read_memos.find(params[:id])

    if @user_read_memo.update_attributes(params[:user_read_memo])
      head :no_content
    else
      render json: @user_read_memo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_read_memos/1
  # DELETE /user_read_memos/1.json
  def destroy
    @user_read_memo = @memo.user_read_memos.find(params[:id])
    @user_read_memo.destroy

    head :no_content
  end
end
