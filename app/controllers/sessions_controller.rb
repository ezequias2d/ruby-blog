class SessionsController < ApplicationController
  layout "session"

  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user
    else
      flash.now[:alert] = "You have entered an invalid email or password"
      render 'new'
    end
  end

  def delete
    session[:user_id] = nil
    flash[:notice] = "You have been signed out successfully"
    redirect_to root_path
  end
end

