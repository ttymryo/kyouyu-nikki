class Public::CommentsController < ApplicationController
  before_action :custom_authenticate
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.diary_id = params[:diary_id]
    if @comment.save
      redirect_to request.referer, notice: 'コメントを送信しました'
    else
      redirect_to request.referer, alert: '送信に失敗しました'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to user_diary_path(params[:user_name_id],params[:diary_id]), notice: 'コメントを削除しました'
  end

  def comment?
    diary = Diary.find(params[:diary_id])
    if diary.add_commented == false
      redirect_to request.referer
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
