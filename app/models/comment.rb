# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  scope :recent, -> { order(created_at: :desc) }

  validates :content, presence: true
  validates :content, length: { maximum: 140 }
end
