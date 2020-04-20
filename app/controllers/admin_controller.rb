class AdminController < ApplicationController
  def index
    @days = 5
    @orders = Order.by_date(@days.day.ago)
  end
  
  def reports
    # redirect_to admin_reports_path
  end

  protected
  def admin_params
    params.require(:admin).permit(:from, :to)
  end

end
