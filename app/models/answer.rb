class Answer < ApplicationRecord
  has_many :results
  belongs_to :word

  scope :correct, ->{where is_correct: true}
end
