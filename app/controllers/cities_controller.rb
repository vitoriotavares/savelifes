# encoding: utf-8
class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]

  add_breadcrumb City.new.model_name.human, :cities_path
  add_breadcrumb I18n.t("breadcrumb.show"), :city_path, only: [:show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_city_path, only: [:new, :create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_city_path, only: [:edit, :update]

  respond_to :html
  def index
    @q = City.all.ransack(params[:q])
    @cities = @q.result.page(params[:page])
  end

  def show

  end

  def new
    @city = City.new
  end

  def edit
  end

  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to cities_url, notice: I18n.t("messages.create.notice") }
        format.json { render :show, status: :created, location: @city }
      else
        format.html { render :new }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @city.update(city_params)
        redirect_to cities_url, notice: t('messages.update.notice')
    else
      render :edit
    end
  end

  def destroy
    if @city.destroy
    redirect_to cities_url, notice: t('messages.destroy.notice')
    else
      redirect_to cities_url, alert: @city.errors
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def city_params
      params.require(:city).permit(:name, :state_id)
    end
end
