# frozen_string_literal: true

module Tweets
  class TweetSerializer < ActiveModel::Serializer
    attributes %i[id content image_url created_at user engagement]

    delegate :image_url, to: :object

    def engagement
      {
        comment: object.comments.size,
        retweet: {
          count: object.retweets.size,
          retweeted: user_interaction_exists?(:retweets),
        },
        like: {
          count: object.likes.size,
          liked: user_interaction_exists?(:likes)
        },
      }
    end

    def user
      Users::UserSerializer.new(object.user).as_json
    end

    def user_interaction_exists?(association)
      object.public_send(association).exists?(user: instance_options[:current_user])
    end
  end
end
