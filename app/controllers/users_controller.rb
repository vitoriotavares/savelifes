# encoding: utf-8
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  add_breadcrumb User.new.model_name.human, :users_path
  add_breadcrumb I18n.t("breadcrumb.show"), :user_path, only: [:show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_user_path, only: [:new, :create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_user_path, only: [:edit, :update]

  respond_to :html
  def index
    @q = User.all.ransack(params[:q])
    @Users = @q.result.page(params[:page])
  end

  def show

  end

  def new
    @user = User.new
  end

  def edit
    # respond_to do |format|
    #   if @user != current_user
    #     format.html { redirect_to edit_user_path(current_user) }
    #   else

    #   end
    # end
  end

  def create
    @user = User.new(User_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: I18n.t("messages.create.notice") }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @user.update(user_params)
        redirect_to my_config_path, notice: t('messages.update.notice')
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
    redirect_to users_url, notice: t('messages.destroy.notice')
    else
      redirect_to users_url, alert: @user.errors
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :corporation, :email, :admin, :phone, :cell_phone, :address, :cnpj, :logo)
    end
end
