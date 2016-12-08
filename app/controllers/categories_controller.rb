class CategoriesController < ApplicationController

  def index
    @categories = Category.search(params[:search]).recent
      .paginate page: params[:page]
  end
end
