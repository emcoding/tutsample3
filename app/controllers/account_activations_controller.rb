class AccountActivationsController < ApplicationController

  def edit
    @user=User.find_by(email: params[:email])
    if user && user.authenticated?(:activation, params[:id])
  #  @user = User.find(params[:id]) #why not: show @user
  end


end
