class Activity < ApplicationRecord
  belongs_to :user

  enum action: [:start_lesson, :finish_lesson, :follow, :unfollow]

  scope :recent, ->{order created_at: :desc}
end
