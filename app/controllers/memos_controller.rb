class MemosController < ApplicationController
  # GET /memos
  # GET /memos.json
  def index
    @memos = Memo.all

    render json: @memos
  end

  # GET /memos/1
  # GET /memos/1.json
  def show
    @memo = Memo.find(params[:id])

    render json: @memo
  end

  # GET /memos/new
  # GET /memos/new.json
  def new
    @memo = Memo.new

    render json: @memo
  end

  # POST /memos
  # POST /memos.json
  def create
    @memo = Memo.new(params[:memo])

    if @memo.save
      render json: @memo, status: :created, location: [@memo.group, @memo]
    else
      render json: @memo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /memos/1
  # PATCH/PUT /memos/1.json
  def update
    @memo = Memo.find(params[:id])

    if @memo.update_attributes(params[:memo])
      head :no_content
    else
      render json: @memo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /memos/1
  # DELETE /memos/1.json
  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy

    head :no_content
  end
end
