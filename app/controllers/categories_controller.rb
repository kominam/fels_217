class CategoriesController < ApplicationController

  def index
    @categories = Category.search(params[:search]).includes(:words).recent
      .paginate page: params[:page]
  end
end
