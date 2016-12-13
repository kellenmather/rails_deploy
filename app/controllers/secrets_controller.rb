class SecretsController < ApplicationController

  before_action :require_login, only: [:index, :create, :destroy]

  def index
    @secrets = Secret.all
  end

  def create
    # HOW CAN I USE STRONG PARAMS AND ADD AN ID AS WELL IN THE .new() function
    secret = Secret.new(content: params[:secret]['content'], user: User.find(session[:user]['id']))
    if secret.save
      redirect_to "/users/#{session[:user]['id']}"
    else
      flash[:errors] = secret.errors.full_messages
      redirect_to "/users/#{session[:user]['id']}"
    end
  end

  def destroy
    secret = Secret.find(params[:id])
    secret.destroy if secret.user == current_user
    redirect_to "/users/#{session[:user]['id']}"
  end

end
