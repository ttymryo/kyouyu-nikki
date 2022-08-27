class Public::RelationshipsController < ApplicationController
  before_action :custom_authenticate
  
  def create
    user = User.find_by!(name_id: params[:user_name_id])
    current_user.follow(user.id)
    redirect_to request.referer, notice: 'フォローしました'
  end

  def destroy
    user = User.find_by!(name_id: params[:user_name_id])
    current_user.unfollow(user.id)
    redirect_to request.referer, notice: 'フォローを解除しました。'
  end
end
