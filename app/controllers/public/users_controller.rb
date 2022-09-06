class Public::UsersController < ApplicationController
  before_action :set_user #@userをセット
  before_action :custom_authenticate #ユーザーでログインしてますか？
  before_action :ensure_correct_user, only: [:edit, :update] #そのページは自分のページですか？
  before_action :is_public?, only: [:follows, :followers] #そのアカウントは公開垢ですか？
  before_action :user_activity_read?, except: [:update] #ユーザーの未読通知を確認

  def set_user
    @user = User.find_by!(name_id: params[:name_id])
  end

  def show
    @diaries = @user.diaries.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
  end

  def update
    # ゲストユーザーの時は保存しない
    if @user.name_id == 'guest_user'
      redirect_to user_path(@user.name_id), notice: 'ゲストユーザーは編集が保存されません'
    else
      if @user.update(user_params)
        redirect_to user_path(@user.name_id), notice: '更新しました'
      else
        flash.now[:alert] = '更新に失敗しました'
        render :edit
      end
    end
  end

  def follows
    @users = @user.following_user
  end

  def followers
    @users = @user.follower_user
  end


  private

  def user_params
    params.require(:user).permit(:name,:name_id,:email,:image,:introduction,:is_public)
  end

  def is_public?
    if @user.is_public == false && @user != current_user
      redirect_to root_path, alert: 'そのページは表示できません'
    end
  end
end
