class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    # alternatively, user = User.where(username: params[:username]).first
    # because User.where gives an array

    if user && user.authenticate(params[:password])
      # save user id not user because cookie has size limit
      session[:user_id] = user.id
      flash[:notice] = 'You are logged in successfully!'
      redirect_to root_path
    else
      flash.now[:notice] = 'There is something wrong with your username and password. Try again or register <a href="/register">here</a>'.html_safe
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out."
    redirect_to root_path
  end

end