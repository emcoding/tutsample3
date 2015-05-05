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
      #handle this
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
