class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #created after including SessionHelper in AppController, and def log_in method
      log_in user
      #puts "I am here (sessionsController#create)" instead of adding 'raise'
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      #redirect_to user
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid combination'

      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
