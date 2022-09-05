class Public::CommentsController < ApplicationController
  before_action :custom_authenticate
  before_action :comment?, only: [:create]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.diary_id = params[:diary_id]
    if @comment.save
      redirect_to request.referer, notice: 'コメントを送信しました'
    else
      @diary = Diary.find(params[:diary_id])
      flash.now[:alert] = '送信に失敗しました'
      render 'public/diaries/show'
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
      redirect_to user_diary_path(diary.user.name_id,diary)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
