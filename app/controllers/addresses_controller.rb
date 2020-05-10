# encoding: utf-8
class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  add_breadcrumb Address.new.model_name.human, :addresses_path
  add_breadcrumb I18n.t("breadcrumb.show"), :address_path, only: [:show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_address_path, only: [:new, :create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_address_path, only: [:edit, :update]

  respond_to :html
  def index
    @q = Address.all.ransack(params[:q])
    @addresses = @q.result.page(params[:page])
  end

  def show

  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @address = Address.new(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to addresses_url, notice: I18n.t("messages.create.notice") }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @address.update(address_params)
        redirect_to addresses_url, notice: t('messages.update.notice')
    else
      render :edit
    end
  end

  def destroy
    if @address.destroy
    redirect_to addresses_url, notice: t('messages.destroy.notice')
    else
      redirect_to addresses_url, alert: @address.errors
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def address_params
      params.require(:address).permit(:address, :number, :neighborhood_id, :zip_code, :complement, :reference_point, :comments)
    end
end
