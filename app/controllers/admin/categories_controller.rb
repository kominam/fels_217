class Admin::CategoriesController < ApplicationController
  before_action :verify_admin
  before_action :load_category, except: [:index, :create]

  def index
    @categories = Category.search(params[:search]).includes(:words).recent
      .paginate page: params[:page]
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".create_success"
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t ".create_fail"
    end
      redirect_to admin_categories_path
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".updated " + @category.name
      redirect_to admin_categories_path
      respond_to do |format|
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".del_success"
    else
      flash[:danger] = t ".del_fail"
    end
    respond_to do |format|
      format.js
    end
    redirect_to admin_categories_path
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
