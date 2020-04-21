class SessionsController < ApplicationController
  skip_before_action :authorize, :check_last_activity
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user.try(:authenticate, params[:password])
      user.set_last_activity
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end
  
  def destroy
    Counter.find_by(user_id:session[:user_id]).destroy
    session[:user_id] = nil
    redirect_to store_index_url, notice: "Logged out."
  end
end
