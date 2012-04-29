class ApplicationController < ActionController::Base
  protect_from_forgery

  ###
  # helpers
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  # Public: Create a new visit or update this visit to the current time
  #
  # post - post that is viewd by the user
  def set_post_to_viewed(post)
    if current_user && post
      visit = Visit.find_by_user_id_and_post_id(current_user.id, post.id)
      if visit.nil?
        visit = Visit.new(post: post, user: current_user)
        visit.save
      else
        visit.updated_at = Time.new
        visit.save
      end
    end
  end
  helper_method :set_post_to_viewed


  ###
  # filter
  before_filter :authenticate
  def authenticate
    if current_user.nil?
      session[:next_wanted_url] = request.url if request.url
      redirect_to(login_path)
    end
  end

end
