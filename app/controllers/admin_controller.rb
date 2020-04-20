class AdminController < ApplicationController
  before_action :ensure_is_admin
  def index
    @orders = Order.by_date(5.day.ago)
  end
  
  def reports
    @from = admin_params[:from]
    @to = admin_params[:to]
    @orders = Order.by_date(@from,@to)
  end

  def categories
    @categories = Category.all
  end

  protected
    def ensure_is_admin
      unless User.find(session[:user_id]).admin?
        redirect_to root_path, notice: "You don't have privilege to access this section"
      end
    end

    def admin_params
      params.require(:admin).permit(:from, :to)
    end

end
