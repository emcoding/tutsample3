class UsersController < ApplicationController
  #adding in 9.2.1 : only logged in user can edit, update, with def logged_in_user below
before_action :logged_in_user,  only: [:index, :edit, :update, :destroy]
  #adding in 9.2.2
before_action :correct_user,    only: [:edit, :update]
before_action :admin_user,      only: :destroy



  def index
  #  @users = User.all
  @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    #µd: with debugger in action, go to terminal to use it.
    #debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #added in ch8.2.5 :
      log_in @user

      #Adding redirect following signup form submission
      #redirect_to user_url(@user) is in short:
      flash[:success] = "Welcome to Mauds Rails App :-) "
      redirect_to @user

    else
      render 'new'
    end
  end

  def edit
  #  @user = User.find(params[:id]) #why not: show @user
  end

  def update
  #  @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile is updated :-) "
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:succes] = "User deleted"
    redirect_to users_url
  end


  private

    def user_params
      params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation )
                                 #, :admin ) #added for exercise 9.3
    end

    #before filters

    def logged_in_user
      unless logged_in?
        store_location   #added in 9.28
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      #redirect_to(root_url) unless @user == current_user
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
