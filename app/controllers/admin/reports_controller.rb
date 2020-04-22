module Admin
  class ReportsController < AdminController
    def index
      @from = filter_params[:from]
      @to = filter_params[:to]
      @orders = Order.by_date(@from,@to)
    end

    protected
      def filter_params
        params.require(:admin).permit(:from, :to)
      end
  end
end