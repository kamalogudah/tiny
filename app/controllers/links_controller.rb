class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  def index
    @links = current_user.links
  end

  def show
    @my_url = request.env['HTTP_HOST']
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  def edit
  end

  def go_to
    @link = Link.where(url_code: params[:code])
    redirect_to @link.first.original
  end

  def code
    Link.where(url_code: params[:code])
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)
    @link.user_id = current_user.id
    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:original, :url_code)
  end
end
