class Admin::ProductsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :new
    end

  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:alert] = "Product deleted"
    redirect_to admin_products_path
  end

  def index
    @products = Product.all
  end

  def sell
    @product = Product.find(params[:id])
    @product.sell!
    redirect_to :back
  end

  def notsell
    @product = Product.find(params[:id])
    @product.notsell!
    redirect_to :back
  end

  def start_auction
    @product = Product.find(params[:id])
    @product.start_auction!
    redirect_to :back
  end

  def deal
    @product = Product.find(params[:id])
    @product.deal!
    redirect_to :back
  end

  def fail
    @product = Product.find(params[:id])
    @product.fail!
    redirect_to :back
  end




  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :buyout, :image, :is_hidden, :begintime, :endtime, :aasm_state)
  end

end
