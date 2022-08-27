class ApplicationController < ActionController::Base
  #findなどで例外が発生した場合リダイレクトする
  rescue_from ActiveRecord::RecordNotFound do |exception|
    # redirect_to :root, alert: 'エラーが発生しました'
    render 'public/users/destroy'
  end


  before_action :user_acteve? #ユーザーは凍結されていない？

  #ユーザーのログイン確認でアドミンでログインしてた時のパス指定
  def custom_authenticate
    if admin_signed_in?
      redirect_to admin_home_path
    else
      authenticate_user!
    end
  end

  #違うアカウントの情報を表示させない
  def ensure_correct_user
    name_id = params[:user_name_id]
    if name_id.nil?
      name_id = params[:name_id]
    end

    user = User.find_by!(name_id: name_id)

    unless user == current_user
      redirect_to root_path, alert: 'このページは表示できません'
    end
  end

  #ログインしたユーザーが凍結されていた場合
  def user_acteve?
    if user_signed_in? && current_user.is_deleted?
      render "public/users/delete"
    end
  end


  #deviseのパスの指定
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
