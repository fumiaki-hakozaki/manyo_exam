class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new,:create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:notice] = 'アカウント作成しました！'
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice:'ログインしました！'
    else
      redirect_to new_user_path, notice: 'Sing upできませんでした！'
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = current_user.tasks
      unless @user == current_user
        redirect_to tasks_path
      end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
