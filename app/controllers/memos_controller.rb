class MemosController < ApplicationController
  # GET /memos
  # GET /memos.json
  before_filter :get_membership

  def get_membership
    if params[:group_id] || params[:id]
      id = params[:group_id] || params[:id]
      @group = Group.find(id)
      @membership = current_user.memberships.where("group_id = ?", @group.id).first
      @group = nil if @membership.nil?
    end
  end

  def index
    @memos = @group.memos

    render json: @memos
  end

  # GET /memos/1
  # GET /memos/1.json
  def show
    @memo = @group.memos.find(params[:id])

    render json: @memo
  end

  # GET /memos/new
  # GET /memos/new.json
  def new
    @memo = @group.memos.build

    render json: @memo
  end

  # POST /memos
  # POST /memos.json
  def create
    @memo = @group.memos.create(params[:memo])

    if @memo.save
      render json: [@group, @memo], status: :created, location: [@group, @memo]
    else
      render json: @memo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /memos/1
  # PATCH/PUT /memos/1.json
  def update
    @memo = @group.memos.find(params[:id])

    if @memo.update_attributes(params[:memo])
      head :no_content
    else
      render json: @memo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /memos/1
  # DELETE /memos/1.json
  def destroy
    @memo = @group.memos.find(params[:id])
    @memo.destroy

    head :no_content
  end
end
