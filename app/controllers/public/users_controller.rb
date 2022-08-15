class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :public_range, only: [:follows, :followers]

  def show
    @user = User.find_by!(name_id: params[:name_id])
    @diaries = @user.diaries.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
    @user = User.find_by!(name_id: params[:name_id])
  end

  def update
    @user = User.find_by!(name_id: params[:name_id])
    # ゲストユーザーの時は保存しない
    if @user.name_id == 'guestuser'
      redirect_to user_path(@user.name_id)
    else
      if @user.update(user_params)
        redirect_to user_path(@user.name_id)
      else
        render :edit
      end
    end
  end

  def destroy
  end

  def follows
    user = User.find_by!(name_id: params[:name_id])
    @users = user.following_user
  end

  def followers
    user = User.find_by!(name_id: params[:name_id])
    @users = user.follower_user
  end

  private

  def user_params
    params.require(:user).permit(:name,:name_id,:email,:image,:introduction,:is_public)
  end

  def ensure_correct_user
    @user = User.find_by(name_id: params[:name_id])
    unless @user == current_user
      flash[:notice] = "アカウントが違うため編集できません"
      redirect_to root_path
    end
  end
  
  def public_range
    @user = User.find_by(name_id: params[:name_id])
    unless @user.is_public?
      redirect_to root_path
    end
  end
end
