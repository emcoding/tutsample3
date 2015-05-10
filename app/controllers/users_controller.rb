class UsersController < ApplicationController


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
    @user = User.find(params[:id]) #why not: show @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile is updated :-) "
      redirect_to @user
    else
      render 'edit'
    end
  end



  private

    def user_params
      params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation)
    end

end
