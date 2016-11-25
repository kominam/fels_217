class Result < ApplicationRecord
  belongs_to :lesson
  belongs_to :word
  belongs_to :answers
end
