class ApplicationController < ActionController::Base

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
