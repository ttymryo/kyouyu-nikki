class Public::DiariesController < ApplicationController
  before_action :custom_authenticate, only: [:new, :create, :update, :edit, :destroy]
  before_action :ensure_correct_user, only: [:update, :edit, :destroy]
  before_action :public_range, only: [:show]

  def show
    @diary = Diary.find(params[:id])
    @comment = Comment.new
  end

  def new
    if @diary = current_user.diaries.last
      @diary.body = ''
    else
      @diary = Diary.new
    end
  end

  def create
    @diary = current_user.diaries.new(diary_params)
    if @diary.save
      redirect_to user_diary_path(@diary.user.name_id,@diary), notice: '投稿しました。'
    else
      flash.now[:alert] = '投稿に失敗しました。'
      render :new
    end
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
      redirect_to user_diary_path(@diary.user.name_id,@diary), notice: '更新しました。'
    else
      flash.now[:alert] = '保存できませんでした。'
      render :edit
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    redirect_to root_path, notice: '投稿を削除しました。'
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def history
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @diaries = current_user.diaries.where(created_at: @month.all_month)
    @day = 0
  end

  private

  def diary_params
    params.require(:diary).permit(:body,:emotion,:add_commented,:public_range)
  end

  def public_range
    @user = User.find_by(name_id: params[:user_name_id])
    unless @user.is_public?
      redirect_to root_path, alert: '投稿が見つかりません'
    end
    @diary = Diary.find(params[:id])
    unless current_user == @diary.user
      if @diary.user && @diary.public_range_i18n == '自分だけ'
        redirect_to root_path, alert: '投稿が見つかりません。'
      elsif @diary.public_range_i18n == 'FF内'
        unless @diary.user.ff?(current_user)
          redirect_to root_path, alert: '投稿が見つかりません。'
        end
      end
    end
  end
end
