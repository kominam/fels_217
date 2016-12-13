class Admin::CategoriesController < ApplicationController
  before_action :verify_admin
  before_action :load_category, except: [:index, :create]

  def index
    @categories = Category.search(params[:search]).includes(:words).recent
      .paginate page: params[:page], per_page: Settings.per_page
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".create_success"
      render json: {category: @category, words: @category.words}
    else
      flash[:danger] = t ".create_fail"
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".updated"
      render json: @category
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".del_success"
    else
      flash[:danger] = t ".del_fail"
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
