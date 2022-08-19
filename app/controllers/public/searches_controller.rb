class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @range = params[:range]

    if @range == 'User'
      @users = User.looks(params[:word])
      unless @users.blank?
        @users = Kaminari.paginate_array(@users).page(params[:page]).per(20)
      end
    elsif @range == 'Diary'
      @diaries = Diary.looks(params[:word]).page(params[:page]).per(20)
    end
  end
end
