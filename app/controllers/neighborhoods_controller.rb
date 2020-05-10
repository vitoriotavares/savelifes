# encoding: utf-8
class NeighborhoodsController < ApplicationController
  before_action :set_neighborhood, only: [:show, :edit, :update, :destroy]

  add_breadcrumb Neighborhood.new.model_name.human, :neighborhoods_path
  add_breadcrumb I18n.t("breadcrumb.show"), :neighborhood_path, only: [:show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_neighborhood_path, only: [:new, :create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_neighborhood_path, only: [:edit, :update]

  respond_to :html
  def index
    @q = Neighborhood.all.ransack(params[:q])
    @neighborhoods = @q.result.page(params[:page])
  end

  def show

  end

  def new
    @neighborhood = Neighborhood.new
  end

  def edit
  end

  def create
    @neighborhood = Neighborhood.new(neighborhood_params)

    respond_to do |format|
      if @neighborhood.save
        format.html { redirect_to neighborhoods_url, notice: I18n.t("messages.create.notice") }
        format.json { render :show, status: :created, location: @neighborhood }
      else
        format.html { render :new }
        format.json { render json: @neighborhood.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @neighborhood.update(neighborhood_params)
        redirect_to neighborhoods_url, notice: t('messages.update.notice')
    else
      render :edit
    end
  end

  def destroy
    if @neighborhood.destroy
    redirect_to neighborhoods_url, notice: t('messages.destroy.notice')
    else
      redirect_to neighborhoods_url, alert: @neighborhood.errors
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_neighborhood
      @neighborhood = Neighborhood.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def neighborhood_params
      params.require(:neighborhood).permit(:name, :city_id)
    end
end
