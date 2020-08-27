class ProductsController < ApplicationController

 
  def index
    @products = Product.all.order(created_at: :desc)
    @categories = Category.all.order(:name)
    if params[:category]
      @products = Category.find(params[:category]).products
    else
      @products=Product.all
    end
  end

  def new
    @product = Product.new
    @categories = Category.all.order(:name)
  end

  def create
    @product = Product.new product_params

    if @product.save
      flash[:success] = "Product created!"
      redirect_to @product
    else
      render :new
    end
  end

  def edit
    @product = Product.find params[:id]
    @category_id = @product.category_id
    @categories = Category.all.order(:name)
  end

  def update
    @product = Product.find params[:id]

    if @product.update(product_params)
      flash[:success] = "Product updated!"
      redirect_to @product
    else
      render :edit
    end
  end

  def show
    @product = Product.find params[:id]
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy
    flash[:danger] = "Product has been deleted."
    redirect_to [:products]
  end

  def product_params
    params.require(:product).permit(:name, :description, :avatar, :price, :quantity, :category_id, :user_id)
  end

  def show
    @product = Product.find params[:id]
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy
    flash[:danger] = "Product has been deleted."
    redirect_to [:products]
  end

  def product_params
    params.require(:product).permit(:name, :description, :avatar, :price, :quantity, :category_id)
  end

end
