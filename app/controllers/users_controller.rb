class UsersController < ApplicationController
  before_action :require_login, except: [:index, :main, :new, :create]
  before_action :require_correct_user, only: [:show, :destroy]

  def index
    redirect_to '/main'
  end

  def main
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/dashboard/#{ session[:user_id] }"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to '/main'
    end
  end

  def show
    @shoes_for_sale = Shoe.where(user_id: session[:user_id]).where.not(:id => Sale.select(:product_id))
    @shoes_bought = Shoe.includes(:user).where(:buyer_id => session[:user_id])
    @shoes_sold = Shoe.includes(:user).where(:seller_id => session[:user_id])
    @earnings = 0
    @shoes_sold.each do |shoe|
      @earnings += shoe.price
    end
    @total = 0
    @shoes_bought.each do |shoe|
      @total += shoe.price
    end
    puts '-------------------------^^^^^^^'
  end

  private
    def user_params
      params.require(:user).permit(:fn, :ln, :email, :password, :password_confirmation)
    end

end
