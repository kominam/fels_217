class WordsController < ApplicationController

  def index
    params[:search] ||= ""
    params[:status] ||= Settings.options.first
    @words = Word.in_category(params[:category_id]).includes(:category)
      .send(params[:status], current_user.id, params[:search]).recent
      .paginate page: params[:page], per_page: Settings.per_page
  end
end
