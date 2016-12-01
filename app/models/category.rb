class Category < ApplicationRecord
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}
end
