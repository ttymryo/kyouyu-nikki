class Public::DiariesController < ApplicationController
  def index
  end

  def show
    @diary = Diary.find(params[:id])
    @comment = Comment.new
  end

  def new
    @diary = Diary.new
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

  private

  def diary_params
    params.require(:diary).permit(:body,:emotion,:add_commented,:public_range)
  end
end
