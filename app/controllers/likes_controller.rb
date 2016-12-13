class LikesController < ApplicationController
  def create
    # WHY WONT BELOW TAKE MY OBJECTS?!?!?!?!?!?!?
    Like.create( user_id: session[:user]['id'], secret_id: params[:secret_id] )
    redirect_to '/secrets'
  end

  def destroy
    Like.find_by( user_id: session[:user]['id'], secret_id: params[:id]).destroy
    redirect_to '/secrets'
  end
end
