class Admin::DashboardController < ApplicationController
  def show
    @count = Product.count
    @categories = Category.count
  end
end
