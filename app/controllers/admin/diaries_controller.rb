class Admin::DiariesController < ApplicationController
  before_action :authenticate_admin!

  def show
    @diary = Diary.find(params[:id])
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
      redirect_to admin_diary_path(@diary)
    else
      render :edit
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    redirect_to admin_home_path
  end

  def comments
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to request.referer
  end

  private

  def diary_params
    params.require(:diary).permit(:body,:emotion,:add_commented,:public_range)
  end
end
