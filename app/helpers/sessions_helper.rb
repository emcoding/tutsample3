module SessionsHelper

  def log_in(user)
    #this session method is a Rails method. It places a temp cookie which expires upon closing the browser
    session[:user_id] = user.id
  end

end
