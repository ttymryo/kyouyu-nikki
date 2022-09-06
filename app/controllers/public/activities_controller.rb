class Public::ActivitiesController < ApplicationController
  before_action :custom_authenticate
  before_action :user_activity_read?, only: [:index, :all] #ユーザーの未読通知を確認

  def index
    @activities = @unread.order(created_at: :desc).page(params[:page]).per(20)
  end

  def all
    @activities = current_user.activities.order(created_at: :desc).page(params[:page]).per(20)
  end

  def read_all
    current_user.activities.where(read: false).update_all(read: true)
    redirect_to request.referer, notice: 'すべて既読にしました'
  end

  def read
    activity = current_user.activities.find(params[:id])
    unless activity.read?
      activity.update(read: true)
    end
    redirect_to activity.subject.redirect_path
  end

end
