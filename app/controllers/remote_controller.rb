class RemoteController < ApplicationController
  include ActionView::Helpers::TextHelper

  skip_before_filter :authenticate
  skip_before_filter :update_last_seen

  def unread_content
    token = params[:token]

    users = User.all.select do |user|
      user.remote_auth_token == token
    end
    raise ActionController::RoutingError.new('Not Found') if users.empty?

    user = users.first

    ###
    # find posts that are new or have new comments
    last_visit = user.last_page_visit
    data = {}

    Post.all.select { |p| p.last_activity > last_visit }.each do |p|
      data[p.id] = {
        post_message: truncate(p.message, :length => 40),
        is_new_post: p.is_newer_than?(last_visit),
        new_comments: p.comments_newer_than(last_visit).size,
      }
    end

    render :json => data
  end
end
