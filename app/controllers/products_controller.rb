#---
# Excerpted from "Agile Web Development with Rails 6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails6 for more book information.
#---
class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all.includes(:category).order(:title)

    respond_to do |format|
      format.html { @products }
      format.json { render json: @products.to_json(only: [:title],include: {category: {only: :name}}) }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @categories_list = Category.list
  end
  
  # GET /products/1/edit
  def edit
    @categories_list = Category.list
  end

  def rate
    # logger.info 'hello'
    rating = Rating.find_by(user_id:session[:user_id], product_id: params[:id])
    if rating
      rating.value = product_params[:product_rating]
      rating.save
    else
      Rating.create(user_id:session[:user_id], product_id: params[:id], value: product_params[:product_rating])
    end

    @rating = product_params[:product_rating]

    respond_to do |format|
      format.js
    end
    # redirect_to store_index_path
  end
  
  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @categories_list = Category.list
    
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product,
        notice: 'Product was successfully created.' }
        format.json { render :show, status: :created,
        location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors,
        status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @categories_list = Category.list
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product,
          notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }

        @products = Product.all.order(:title)
        ActionCable.server.broadcast 'products',
          html: render_to_string('store/index', layout: false)
      else
        format.html { render :edit }
        format.json { render json: @product.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url,
          notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :enabled, :discount_price, :permalink,:category_id, :product_rating, product_images: [])
    end
end
