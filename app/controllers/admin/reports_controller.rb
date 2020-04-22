module Admin
  class ReportsController < AdminController
    def index
      @from = Time.parse(filter_params[:from]).beginning_of_day
      @to = Time.parse(filter_params[:to]).end_of_day
      @orders = Order.by_date(@from,@to)
    end

    protected
      def filter_params
        params.require(:admin).permit(:from, :to)
      end
  end
end