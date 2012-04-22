class ApplicationController < ActionController::Base
  protect_from_forgery

  ###
  # helpers
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def set_post_to_viewed(post)
    session[:post_visits] = [] unless session[:post_visits].is_a? Array
    session[:post_visits][post.id] = Time.now
  end
  helper_method :set_post_to_viewed


  ###
  # filter
  before_filter :authenticate
  def authenticate
    redirect_to(login_path) if current_user.nil?
  end

  before_filter :update_last_seen
  def update_last_seen
    # every five minutes the last_seen_at value is updated
    date = current_user.last_seen_at if current_user
    date = (Time.new - 1.day) unless date

    if current_user && (Time.now - date) > 300
      current_user.last_seen_at = Time.now
      current_user.save
    end
  end
end
