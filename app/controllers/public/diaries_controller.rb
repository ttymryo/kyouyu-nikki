class Public::DiariesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :ensure_correct_user, only: [:update, :edit, :destroy]
  before_action :public_range, only: [:show]

  def index
  end

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
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    redirect_to root_path
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def history
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @diaries = Diary.where(created_at: @month.all_month).page(params[:page]).per(20)
  end

  private

  def diary_params
    params.require(:diary).permit(:body,:emotion,:add_commented,:public_range)
  end

  def ensure_correct_user
    @user = User.find_by(name_id: params[:user_name_id])
    unless @user == current_user
      flash[:notice] = "アカウントが違うため編集できません"
      redirect_to root_path
    end
  end

  def public_range
    @user = User.find_by(name_id: params[:user_name_id])
    unless @user.is_public?
      redirect_to root_path
    end
  end
end
