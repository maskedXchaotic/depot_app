class AdminController < ApplicationController
  def index
    @total_orders = Order.count
    @categories = Category.eager_load(:sub_categories)
  end
end
