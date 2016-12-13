class CategoriesController < ApplicationController

  def index
    @categories = Category.search(params[:search]).includes(:words).recent
      .paginate page: params[:page], per_page: Settings.per_page
  end
end
