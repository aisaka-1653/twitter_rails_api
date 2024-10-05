# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  scope :recent, -> { order(created_at: :desc) }

  def image_url
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end
end
