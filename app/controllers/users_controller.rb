class UsersController < ApplicationController
  before_action :require_login, except: [:index, :new, :create]

  def index
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/users/#{ session[:user_id] }"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to root_path
    end
  end

  def show
  end

  private
    def user_params
      params.require(:user).permit(:fn, :ln, :email, :password, :password_confirmation)
    end

end
