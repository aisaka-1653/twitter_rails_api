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
          retweeted: retweeted?
        }
      }
    end

    def user
      Users::UserSerializer.new(object.user).as_json
    end

    def retweeted?
      object.retweets.exists?(user: instance_options[:current_user])
    end
  end
end
