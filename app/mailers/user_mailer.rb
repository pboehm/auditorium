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
end
