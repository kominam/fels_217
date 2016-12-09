class Admin::CsvController < ApplicationController

  def index
    @words = Word.order(:created_at)
    respond_to do |format|
      format.html
      format.csv {send_data @words.to_csv, filename: "words-#{Date.today}"}
    end
  end

  def create
    Word.import params[:file]
    redirect_to root_path, notice: t(".imported")
  end
end
