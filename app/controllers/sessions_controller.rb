class SessionsController < ApplicationController
  skip_before_filter :authenticate

  before_filter :redirect_if_user_is_already_logged_in,
                :only => [ :new, :create ]

  def redirect_if_user_is_already_logged_in
    redirect_to(root_path) if current_user
  end

  #########
  # actions
  def new
  end

  def create
    email = User.normalize_email(params[:email])
    user = User.find_by_email(email)

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Erfolgreich eingeloggt!"
    else
      flash.now.alert = "E-Mail oder Passwort sind nicht korrekt!"
      render "new"
    end
  end

  def destroy
     session[:user_id] = nil
     redirect_to root_url, :notice => "Erfolgreich ausgeloggt!"
  end
end
