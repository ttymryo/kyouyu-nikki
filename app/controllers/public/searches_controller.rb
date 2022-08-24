class Public::SearchesController < ApplicationController
  before_action :signed_in?

  def search
    @word = params[:word]
    @range = params[:range]

    if @range == 'User'
      @users = User.looks(params[:word])
      unless @users.blank?
        @users = Kaminari.paginate_array(@users).page(params[:page]).per(20)
      end
    elsif @range == 'Diary'
      @diaries = Diary.looks(params[:word]).page(params[:page]).per(20).order(created_at: :desc)
    end

    if admin_signed_in?
      render 'admin/searches/search'
    end
  end

  def signed_in?
    unless user_signed_in? || admin_signed_in?
      redirect_to root_path
    end
  end
end
