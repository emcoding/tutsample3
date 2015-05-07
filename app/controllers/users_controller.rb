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


  private

    def user_params
      params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation)
    end

end
