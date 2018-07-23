class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = 'You have successfully logged in'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "Somethig went wrong, try again"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You logged out"
    redirect_to root_path
  end
end