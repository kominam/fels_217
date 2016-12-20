class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :results, dependent: :destroy

  before_create :word_for_lesson
  delegate :name, to: :category, prefix: true

  validate :lesson_size

  accepts_nested_attributes_for :results,
    reject_if: proc{|attributes| attributes[:answer_id].blank?}

  scope :recent, ->{order created_at: :desc}

  def word_for_lesson
    self.category.words.limit(Settings.word_per_lesson).shuffle.each do |word|
      self.results.build word_id: word.id
    end
  end

  def lesson_size
    if self.category.words.size < Settings.lesson_size
      self.errors.add :lesson, I18n.t(".not_enough_word")
    end
  end

  def number_correct_answer
    self.results.correct.count if self.is_complete?
  end

  def start_lesson_action user
    user.activities.create action_type: Activity.actions[:start_lesson],
      target_id: self.id
  end

  def finish_lesson_action user
    user.activities.create action_type: Activity.actions[:finish_lesson],
      target_id: self.id
  end
end
