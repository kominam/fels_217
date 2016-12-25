class WordsController < ApplicationController
  before_action :load_all_category, only: :index

  def index
    params[:search] ||= ""
    params[:status] ||= Settings.options.first
    @words = Word.in_category(params[:category_id]).includes(:category)
      .send(params[:status], current_user.id, params[:search]).recent
      .paginate page: params[:page], per_page: Settings.per_page
    if request.xhr?
      render partial: "word", collection: @words
    end
  end
end
