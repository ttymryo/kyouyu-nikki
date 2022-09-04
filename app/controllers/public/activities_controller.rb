class Public::ActivitiesController < ApplicationController
  before_action :custom_authenticate

  def index
    @activities = current_user.activities.order(created_at: :desc).page(params[:page]).per(20)
  end

  def destroy
    current_uesr.activities.destroy_all
    redirect_to user_activities_path(current_user.name_id)
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
      user_diary_path(activity.subject.user.name_id,activity.subject.diary.id)
    when 'comment'
      user_diary_path(activity.subject.user.name_id,activity.subject.diary.id)
    when 'follow'
      user_path(activity.subject.user.name_id)
    end
  end
end
