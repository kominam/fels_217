class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :results, dependent: :destroy
  before_create :word_for_lesson

  accepts_nested_attributes_for :results,
    reject_if: proc{|attributes| attributes[:answer_id].blank?}

  def word_for_lesson
    self.category.words.limit(Settings.word_per_lesson).shuffle.each do |word|
      self.results.build word_id: word.id
    end
  end

  def number_correct_answer
    self.results.correct.count if self.is_complete?
  end
end
