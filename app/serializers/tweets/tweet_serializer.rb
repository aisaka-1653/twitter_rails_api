# frozen_string_literal: true

module Tweets
  class TweetSerializer < ActiveModel::Serializer
    attributes %i[id content image_url created_at user engagement]

    delegate :image_url, to: :object

    def engagement
      {
        comment: object.comments.size,
        retweet: retweet_engagement,
        like: like_engagement
      }
    end

    private

    def user
      Users::UserSerializer.new(object.user).as_json
    end

    def user_interaction_exists?(association)
      object.public_send(association).exists?(user: instance_options[:current_user])
    end

    def comment_count
      object :comment.size
    end

    def retweet_engagement
      {
        count: object.retweets.size,
        retweeted: user_interaction_exists?(:retweets)
      }
    end

    def like_engagement
      {
        count: object.likes.size,
        liked: user_interaction_exists?(:likes)
      }
    end
  end
end
