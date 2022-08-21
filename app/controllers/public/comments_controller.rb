class Public::CommentsController < ApplicationController
  before_action :custom_authenticate
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.diary_id = params[:diary_id]
    if @comment.save
      redirect_to request.referer
    else
      @diary = Diary.find(params[:diary_id])
      render 'public/diaries/show'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to user_diary_path(params[:user_name_id],params[:diary_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
