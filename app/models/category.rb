class Category < ApplicationRecord
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :restrict_with_error

  validates :name, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}

  scope :search, ->search {where "name LIKE ?", "%#{search}%"}
  scope :recent, ->{order "categories.created_at DESC"}
end
