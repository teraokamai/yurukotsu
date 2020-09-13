class CategoriesController < ApplicationController
  before_action :authenticate_account!
  layout "categories"

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
    account = current_account
    @category.account_id = account.id
  end

  def create
    @category = Category.new(categories_params)
    if @category.save
      redirect_to categories_path
    else
      render "new"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(categories_params)
      redirect_to categories_path
    else
      render "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  private

  def categories_params
    params.require(:category).permit(:name, :account_id)
  end
end
