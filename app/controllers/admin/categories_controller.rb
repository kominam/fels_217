class Admin::CategoriesController < ApplicationController
  before_action :admin_user

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".create_success"
      redirect_to root_path
    else
      flash.now[:danger] = t ".create_fail"
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
