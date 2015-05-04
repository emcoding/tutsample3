class UsersController < ApplicationController

  def new
  end

  def show
    @user = User.find(params[:id])
    #µd: with debugger in action, go to terminal to use it. 
    #debugger
  end

end
