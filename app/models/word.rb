class Word < ApplicationRecord
  belongs_to :category
  has_many :results
  has_many :answers, dependent: :destroy, inverse_of: :word

  validates :content, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc{|attributes| attributes["content"].blank?}

  def self.import file
    CSV.foreach(file.path, headers: true, col_sep: "|", header_converters: :symbol) do |row|
      row = row.to_hash
      answers_attributes = []
      row[:answers].split(";").each do |answer|
        answer_hash = Hash.new
        arr_answer = answer.split(",")
        answer_hash[:content] = arr_answer[0]
        answer_hash[:is_correct] = arr_answer[1]
        answers_attributes.push answer_hash
      end
      row[:answers_attributes] = answers_attributes
      row.delete :answers
      Word.create! row
    end
  end

  def self.export
    attributes = %w{id content category_id}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |word|
        csv << attributes.map{|attr| word.send(attr)}
      end
    end
  end
end
