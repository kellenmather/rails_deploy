class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_login
    redirect_to root_path if session[:user_id] == nil
  end

  def require_correct_user
    user = User.find_by(id: params[:id])
    redirect_to "/dashboard/#{current_user.id}" if current_user != user
  end

end
