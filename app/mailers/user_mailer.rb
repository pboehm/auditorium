class UserMailer < ActionMailer::Base
  default from: "auditorium@pboehm.org"

  # Public: Sends a notification about a new post to a user
  #
  # user - User that should receive the notification
  # post - post that should be delivered to the user
  #
  def send_notification_to_user(post)
    @post = post

    recipients = User.find_all_by_notify_new_posts(true).
                      select {|u| u != post.user }.
                      map {|u| "#{u.name} <#{u.email}>"}

    mail(:bcc => recipients,
         :subject => "Auditorium Breaking News (Neue Diskussion)").deliver
  end
end
