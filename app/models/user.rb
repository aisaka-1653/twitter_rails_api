# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :timeoutable
  include DeviseTokenAuth::Concerns::User
  has_one_attached :avatar
  has_one_attached :header
end
