class WordsController < ApplicationController

  def index
    @words = Word.all_words(params[:category_id]).search(params[:search])
      .paginate page: params[:page], per_page: Settings.per_page
  end
end
