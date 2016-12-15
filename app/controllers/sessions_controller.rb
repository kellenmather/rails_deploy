class SessionsController < ApplicationController

  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to "/dashboard/#{ session[:user_id] }"
    else
      flash[:errors] = ['Invalid Credentials']
      redirect_to '/main'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/main'
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end

end
