class CategoriesController < ApplicationController

  def index
    @categories = Category.search(params[:search]).includes(:words).recent
      .paginate page: params[:page], per_page: Settings.per_page
    if request.xhr?
      render partial: "category", collection: @categories
    end
  end
end
