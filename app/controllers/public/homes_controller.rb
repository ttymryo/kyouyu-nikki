class Public::HomesController < ApplicationController
  before_action :authenticate_user!, only: [:sort]
  before_action :set_diary_new, only: [:top, :about]

  def top
    @word = 'ホーム'
    @diaries = Diary.all.order(created_at: :desc).page(params[:page]).per(20)
  end

  def sort
    #送られてきた値をそれぞれの処理で降順になるように配列をいじる
    @word = params[:word]
    case @word
    when 'いいね' then
      @diaries = []
      current_user.favorites.each do |favorite|
        @diaries.push(favorite.diary)
      end
      @diaries.flatten!
      @diaries = Kaminari.paginate_array(@diaries).page(params[:page]).per(20)
    when 'フォロー' then
      @diaries = []
      current_user.following_user.each do |user|
        @diaries.push(user.diaries)
      end
      @diaries.flatten!
      @diaries = Kaminari.paginate_array(@diaries.sort_by{|diary| diary.id}.reverse).page(params[:page]).per(20)
    when 'FF公開限定' then
      @diaries = []
      current_user.following_user.each do |user|
        if current_user.follower?(user)
          user.diaries.each do |diary|
            if diary.public_range == 'in_ff'
              @diaries.push(diary)
            end
          end
        end
      end
      @diaries.flatten!
      @diaries = Kaminari.paginate_array(@diaries.sort_by{|diary| diary.id}.reverse).page(params[:page]).per(20)
    else
      @word = 'ホーム'
      @diaries = Diary.all.order(created_at: :desc).page(params[:page]).per(20)
    end
    render :top
  end

  def about
  end

  def set_diary_new
    if @diary = current_user.diaries.last
      @diary.body = ''
    else
      @diary = Diary.new
    end
  end
end
