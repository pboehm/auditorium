class UserMailer < ActionMailer::Base
  default from: "auditorium@i77i.de"

  # Public: Sends a notification about a new post to a user
  #
  # user - User that should receive the notification
  # post - post that should be delivered to the user
  #
  def new_post_notification(user, post)
    @user = user
    @post = post

    mail(:to => "#{user.name} <#{user.email}>",
         :subject => "Auditorium Breaking News (Neue Diskussion)")
  end

  # Public: finds the user that should be notified
  #
  # post - post that the user should be notified
  def send_notification_to_user(post)

    User.find_all_by_notify_new_posts(true).each do |user|
      next if user == post.user

      UserMailer.new_post_notification(user, post).deliver
    end
  end
end
