class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.order(id: :desc).all
    @categoryId = []
    @categories.each do |id|
      @categoryId.push(id[:id].to_i)
    end
    @categoryId.each do |id|
      @productsWithCategory = Product.where("category_id = #{id}")
      @productCount = @productsWithCategory.count
    end
    
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

  def category_params
    params.require(:category).permit(
      :id, 
      :name
    )
  end

end