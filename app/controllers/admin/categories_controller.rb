class Admin::CategoriesController < ApplicationController

  def index
    #selects for all Categories and sorts by Quantity of Products belonging to that Category
    @categories = Category.joins('LEFT JOIN products on categories.id = products.category_id').group(:id).order('COUNT(products.quantity) DESC')
    @count = Category.count
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private
  # NOT IN USE AT THIS TIME
  # def category_params
  #   params.require(:category).permit(
  #     :id, 
  #     :name
  #   )
  # end

end