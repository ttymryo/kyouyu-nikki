class Public::ActivitiesController < ApplicationController
  before_action :custom_authenticate

  def index
    @activities = current_user.activities.where(read: false).order(created_at: :desc).page(params[:page]).per(20)
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
    redirect_to transition_path(activity)
  end

  def transition_path(activity)#アクションタイプごとにリダイレクト先を指定
    case activity.action_type
    when 'favorite'
      user_diary_path(activity.subject.diary.user.name_id,activity.subject.diary.id)
    when 'comment'
      user_diary_path(activity.subject.diary.user.name_id,activity.subject.diary.id)
    when 'follow'
      user_path(activity.subject.follower.name_id)
    end
  end
end
