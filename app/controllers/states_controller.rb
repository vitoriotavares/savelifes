# encoding: utf-8
class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]

  add_breadcrumb State.new.model_name.human, :states_path
  add_breadcrumb I18n.t("breadcrumb.show"), :state_path, only: [:show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_state_path, only: [:new, :create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_state_path, only: [:edit, :update]

  respond_to :html
  def index
    @q = State.all.ransack(params[:q])
    @states = @q.result.page(params[:page])
  end

  def show

  end

  def new
    @state = State.new
  end

  def edit
  end

  def create
    @state = State.new(state_params)

    respond_to do |format|
      if @state.save
        format.html { redirect_to states_url, notice: I18n.t("messages.create.notice") }
        format.json { render :show, status: :created, location: @state }
      else
        format.html { render :new }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @state.update(state_params)
        redirect_to states_url, notice: t('messages.update.notice')
    else
      render :edit
    end
  end

  def destroy
    if @state.destroy
    redirect_to states_url, notice: t('messages.destroy.notice')
    else
      redirect_to states_url, alert: @state.errors
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def state_params
      params.require(:state).permit(:name, :initials)
    end
end
