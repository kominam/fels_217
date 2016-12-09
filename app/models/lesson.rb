class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :results, dependent: :destroy
  before_create :word_for_lesson

  accepts_nested_attributes_for :results,
    reject_if: proc{|attributes| attributes["content"].blank?}

  def word_for_lesson
    self.category.words.order("Random()").limit(4).each do |word|
      self.results.build word_id: word.id
    end
  end
end
