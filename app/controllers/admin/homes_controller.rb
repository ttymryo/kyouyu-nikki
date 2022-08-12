class Admin::HomesController < ApplicationController
  def top
    @diaries = Diary.all.order(created_at: :desc).page(params[:page]).per(20)
  end
end
