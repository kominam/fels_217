class Word < ApplicationRecord
  belongs_to :category
  has_many :results
  has_many :answers, dependent: :destroy
end
