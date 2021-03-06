class SessionsController < ApplicationController

  skip_before_action :logged_in?, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:danger] = 'User not found'
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    flash[:success] = 'Logged Out Successfully'
    redirect_to login_path
  end

end
