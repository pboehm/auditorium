# encoding: utf-8
class UsersController < ApplicationController
  def new
    @user = User.new
    @title = "Nutzer anlegen"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      @title = "Nutzer anlegen"
      render "new"
    end
  end

  def edit
    @title = "Passwort ändern"
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      redirect_to root_path, notice: 'Passwort erfolgreich geändert'
    else
      flash[:error] = "Passwort konnte nicht geändert werden"
      render action: "edit"
    end

  end
end
