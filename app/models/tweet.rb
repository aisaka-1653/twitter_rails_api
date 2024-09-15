# frozen_string_literal: true

class Tweet < ApplicationRecord
  has_one_attached :image
end
