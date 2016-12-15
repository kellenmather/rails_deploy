class ShoesController < ApplicationController

  # Display Shoe Store
  def index
    # @shoes = Shoe.joins("LEFT JOIN sales ON sales.product_id = shoe.id").where()
    @shoes = Shoe.includes(:user).where.not(:id => Sale.select(:product_id))
    puts @shoes
    puts '-------------------------------------'
  end

  # Add a Product
  def create
    shoe = Shoe.new(shoe_params.merge({date: DateTime.now, user_id: session[:user_id]}))
    if shoe.save
      redirect_to :back
    else
      flash[:errors] = shoe.errors.full_messages
      redirect_to :back
    end
  end

  # Remove an added Product
  def destroy
    Shoe.find(params[:id]).destroy
    redirect_to :back
  end

  # Buy a Product (accesses Sale model - to prevent repeat of times already bought)
  def buy
    shoe = Shoe.find(params[:id])
    Sale.create(user_id: session[:user_id], product_id: params[:id], p_u_id: shoe.user_id)
    shoe.update(buyer_id: session[:user_id], seller_id: shoe.user_id, date_bought_sold: DateTime.now, seller_name: current_user.fn)
    redirect_to "/dashboard/#{session[:user_id]}"
  end


  private
    def shoe_params
      params.require(:shoe).permit(:name, :date, :price, :user_id)
    end
end
