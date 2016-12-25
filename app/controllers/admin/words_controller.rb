class Admin::WordsController < ApplicationController
  before_action :verify_admin
  before_action :load_all_category, except: :show
  before_action :load_word, except: [:index,:create, :new]

  def index
    @words = Word.in_category(params[:category_id])
      .all_words(current_user.id, params[:search]).includes(:category)
      .paginate page: params[:page], per_page: Settings.per_page
    if request.xhr?
      render partial: "word", collection: @words
    end
  end

  def show
    @answers = @word.answers
  end

  def edit
  end

  def new
    @word = Word.new
    Settings.answer_number.times.each do
      @word.answers.build
    end
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t ".word_created"
      redirect_to admin_words_path
    else
      flash[:danger] = t ".create_word_failed"
      render :new
    end
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t ".word_updated"
      redirect_to admin_words_path
    else
      flash.now[:danger] = t ".word_udpate_fail"
      redirect_to categories_path
    end
  end

  def destroy
    if @word.is_exist?
      flash[:danger] = t ".fail_destroy_word"
    else
      @word.destroy
      flash[:success] = t ".word_destroyed"
    end
    redirect_to :back
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_word
    @word = Word.find_by id: params[:id]
    render_404 if @word.nil?
  end
end
