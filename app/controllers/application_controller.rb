class ApplicationController < ActionController::Base
  before_action :user_acteve?

  def custom_authenticate
    if admin_signed_in?
      redirect_to admin_home_path
    else
      authenticate_user!
    end
  end

  def ensure_correct_user
    @user = User.find_by(name_id: params[:user_name_id])
    if @user.nil?
      @user = User.find_by(name_id: params[:name_id])
    end

    unless @user == current_user
      flash[:notice] = "アカウントが違うため編集できません"
      redirect_to root_path
    end
  end

  def user_acteve?
    if user_signed_in? && current_user.is_deleted?
      render "public/users/delete"
    end
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin then
      admin_home_path
    when User then
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :admin then
      new_admin_session_path
    when :user then
      root_path
    end
  end
end
