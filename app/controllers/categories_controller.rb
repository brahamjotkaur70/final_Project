class CategoriesController < ApplicationController
    def show
        @category = Category.find(params[:id])
        @products = @category.products.order(created_at: :desc)
      end
      def index
        @categories = Category.order(id: :desc).all
      end
    
      def new
        @category = Category.new
      end
    
      def create
        @category = Category.new(category_params)
    
        if @category.save
          flash[:success] = "New category created!"
          redirect_to [:categories]
        else
          render :new
        end
      end
    
      def destroy
        @category = Category.find params[:id]
        @category.destroy
        flash[:danger] = "Category deleted!"
        redirect_to [:categories]
      end
    
      private
    
      def category_params
        params.require(:category).permit(
          :name
        )
      end
end
