class Public::CommentsController < ApplicationController
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

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
