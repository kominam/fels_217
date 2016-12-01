class Admin::CategoriesController < ApplicationController
  before_action :admin_user
  before_action :load_category, except: [:index, :new, :create]

  def index
    @categories = Category.search(params[:search]).recent
      .paginate page: params[:page]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".create_success"
      redirect_to admin_categories_path
    else
      flash.now[:danger] = t ".create_fail"
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    render_404 if @category.nil?
  end
end
