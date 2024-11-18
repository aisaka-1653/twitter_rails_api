# frozen_string_literal: true

class UserFollow < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  validates :from_user_id, uniqueness: { scope: :to_user_id }
end
