# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :timeoutable
  include DeviseTokenAuth::Concerns::User
  has_one_attached :avatar
  has_one_attached :header

  validates :display_name, :username, :date_of_birth, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :display_name, :username, length: { maximum: 50 }
  validates :bio, length: { maximum: 160 }
  validates :location, length: { maximum: 30 }
  validates :website, length: { maximum: 100 }
end
