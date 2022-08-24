class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all.page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
    @diaries = @user.diaries.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params_user)
      if @user.is_deleted?
        @user.update(is_public: false)
      end
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  private

  def params_user
    params.require(:user).permit(:name,:name_id,:email,:image,:introduction,:is_public,:is_deleted)
  end
end
