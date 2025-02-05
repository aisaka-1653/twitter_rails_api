# frozen_string_literal: true

class User < ApplicationRecord
  before_create :attach_default_image

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :timeoutable
  include DeviseTokenAuth::Concerns::User

  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :retweeted_tweets, -> { merge(Retweet.recent) }, through: :retweets, source: :tweet
  has_many :liked_tweets, -> { merge(Like.recent) }, through: :likes, source: :tweet

  has_many :active_follows, class_name: 'UserFollow', foreign_key: :from_user_id, dependent: :destroy,
                            inverse_of: :from_user
  has_many :passive_follows, class_name: 'UserFollow', foreign_key: :to_user_id, dependent: :destroy,
                             inverse_of: :to_user
  has_many :following, through: :active_follows, source: :to_user
  has_many :followers, through: :passive_follows, source: :from_user

  has_one_attached :avatar
  has_one_attached :header

  validates :display_name, :username, :date_of_birth, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :display_name, :username, length: { maximum: 50 }
  validates :bio, length: { maximum: 160 }
  validates :location, length: { maximum: 30 }
  validates :website, length: { maximum: 100 }

  def avatar_url
    Rails.application.routes.url_helpers.url_for(avatar) if avatar.attached?
  end

  def header_url
    Rails.application.routes.url_helpers.url_for(header) if header.attached?
  end

  def follow(other_user)
    following << other_user unless following?(other_user)
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

  def attach_default_image
    return if avatar.attached?

    avatar.attach(io: Rails.public_path.join('images/default_avatar.png').open, filename: 'default-avatar.png',
                  content_type: 'image/png')
    header.attach(io: Rails.public_path.join('images/default_header.png').open,
                  filename: 'default-header.png', content_type: 'image/png')
  end
end
