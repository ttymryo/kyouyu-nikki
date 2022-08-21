class Public::FavoritesController < ApplicationController
  before_action :custom_authenticate

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

end
