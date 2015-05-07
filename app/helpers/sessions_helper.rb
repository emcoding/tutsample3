module SessionsHelper

  def log_in(user)
    #this session method is a Rails method. It places a temp cookie which expires upon closing the browser
    session[:user_id] = user.id
  end

  #return the current logged-in user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

end
