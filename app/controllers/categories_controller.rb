class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end
    
  def create
    @category = Category.new(secure_params)
    if @category.save
      redirect_to @category
    else
      render 'new'
    end    
  end
  
  def index
    @categories = Category.order(:name)
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(secure_params)
      redirect_to @category, :notice => "Category updated."
    else
      redirect_to 'edit', :alert => "Unable to update category."
    end
  end

  def destroy
    category = Category.find(params[:id])

    category.destroy
    redirect_to categories_path, :notice => "#{category.name} deleted."
  end

  private

  def secure_params
    params.require(:category).permit(:name, :new_category_name, :category_ids)
  end
end