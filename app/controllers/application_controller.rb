class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user


  before_filter :authenticate
  def authenticate
    redirect_to(login_path) if current_user.nil?
  end
end
