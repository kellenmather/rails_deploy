class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by( email: login_params[:email] )
    if user && user.authenticate(login_params[:password])
      session[:user] = {id: user[:id], name: user[:name], email: user[:email]}
      redirect_to "/users/#{user[:id]}"
    else
      flash[:errors] = ["Invalid combination"]
      redirect_to '/sessions/new'
    end
  end

  def destroy
    session[:user] = nil
    redirect_to '/'
  end

  private
    def login_params
      params.require(:user).permit(:email, :password)
    end
end
