class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    Category.create(categories_params)
    redirect_to "/categories"
  end

  private

  def categories_params
    params.require(:category).permit(:name, :account_id)
  end
end
