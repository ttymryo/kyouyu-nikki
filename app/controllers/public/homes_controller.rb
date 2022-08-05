class Public::HomesController < ApplicationController
  def top
    @diaries = Diary.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def about
  end
end
