class Result < ApplicationRecord
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer

  scope :correct, ->{joins(:answer).merge(Answer.correct)}
end
