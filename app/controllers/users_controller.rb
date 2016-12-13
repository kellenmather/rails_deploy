class UsersController < ApplicationController

  before_action :require_login, except: [:index, :new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def index

  end

  def new

  end

  def create
    user = User.new( user_params )
    if user.save
      session[:user] = {id: user[:id], name: user[:name], email: user[:email]}
      redirect_to "/users/#{session[:user][:id]}"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to '/users/new'
    end
  end

  def dashboard
  end

  def edit
  end

  def update
    if User.update(params[:id], user_params1)
      session[:user] = {id: params[:id], name: user_params1['name'], email: user_params1['email']}
      redirect_to "/users/#{params[:id]}"
    else
      flash[:errors] = "Failed to update user information"
      redirect_to "/users/#{session[:user]['id']}/edit"
    end
  end

  def destroy
    session[:user] = nil
    User.find(params[:id]).destroy
    redirect_to '/'
  end

  def show
    @secrets = Secret.where(user_id: session[:user]['id'])
    @secrets_liked = User.find(session[:user]['id']).secrets_liked
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :confirm_password)
    end
    def user_params1
      params.require(:user).permit(:name, :email)
    end

end
