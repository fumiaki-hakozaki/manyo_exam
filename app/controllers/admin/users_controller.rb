class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :edit, :destroy]
  # before_action :if_not_admin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if user.save
      redirect_to admin_users_path, notice:'ユーザーを作成'
    else
      render :new
    end
  end

  def show
  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice:'ユーザー情報を更新'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice:'ユーザー情報を削除'
  end


  private
  # def if_not_admin
  #   redirect_to root_path current_user.admin?
  # end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
