class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(resource)
    users_facebook_oauth_path
  end

  def set_user
    @user = User.first
  end
end
