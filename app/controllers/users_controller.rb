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
end
