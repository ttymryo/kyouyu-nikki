class Public::RelationshipsController < ApplicationController
  def create
    user = User.find_by!(name_id: params[:user_name_id])
    if current_user.follow(user.id)
    redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    user = User.find_by!(name_id: params[:user_name_id])
    current_user.unfollow(user.id)
    redirect_to request.referer
  end
end
