module SessionsHelper

  def log_in(user)
    #this session method is a Rails method. It places a temp cookie which expires upon closing the browser
    session[:user_id] = user.id
  end

  #added in ch8.4
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #adding in listing 9.24. (returns true if the given user is the correct user)
  #Not sure if this is right? :
  def current_user?(user)
    user == current_user
  end


  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])

      #extra test uit listing 8.53
      #raise
      # my way:
      #puts "I was here def current user"
      user = User.find_by(id: user_id)

      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  #added in 9.27
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
