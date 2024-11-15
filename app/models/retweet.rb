# frozen_string_literal: true

class Retweet < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  scope :recent, -> { order(created_at: :desc) }
end
