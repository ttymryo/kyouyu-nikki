class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user

  def create
    @diary = Diary.find(params[:diary_id])
    @favorite = current_user.favorites.new(diary_id: @diary.id)
    @favorite.save
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    @favorite = current_user.favorites.find_by(diary_id: @diary.id)
    @favorite.destroy
  end

  private

  def ensure_correct_user
    @user = User.find_by(name_id: params[:user_name_id])
    unless @user == current_user
      flash[:notice] = "アカウントが違います"
      redirect_to root_path
    end
  end
end
