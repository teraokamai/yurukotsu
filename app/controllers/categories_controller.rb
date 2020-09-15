class CategoriesController < ApplicationController
  before_action :authenticate_account!
  layout "categories"

  def index
    @categories = Category.where(account_id: current_account.id)
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
    if @category.isDefault == true
      redirect_to categories_path, alert: "「" + @category.name + "」は編集できません。"
    end
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
    if @category.isDefault == true
      redirect_to categories_path, alert: "「" + @category.name + "」は削除できません。"
    else
      records = Record.where(category_id: @category.id)

      if records
        defaultCategory = Category.where("isDefault == 1 and account_id == ?", current_account.id)
        Record.where(category_id: @category.id).update_all(category_id: defaultCategory[0].id)
      end

      @category.destroy
      redirect_to categories_path, notice: "カテゴリを削除しました。"
    end
  end

  private

  def categories_params
    params.require(:category).permit(:name, :account_id, :isDefault)
  end
end
