class Public::RelationshipsController < ApplicationController
  before_action :custom_authenticate
  before_action :myself?

  def create
    current_user.follow(@user.id)
    redirect_to request.referer, notice: 'フォローしました'
  end

  def destroy
    current_user.unfollow(@user.id)
    redirect_to request.referer, notice: 'フォローを解除しました。'
  end

  def myself?
    @user = User.find_by!(name_id: params[:user_name_id])
    if current_user == @user
      redirect_to request.referer, alert: '自分はフォローできません'
    end
  end
end
