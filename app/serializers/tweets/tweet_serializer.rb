# frozen_string_literal: true

module Tweets
  class TweetSerializer < ActiveModel::Serializer
    attributes %i[id content image_url created_at user engagement]

    delegate :image_url, to: :object

    def engagement
      { comment: object.comments.count }
    end

    def user
      Users::UserSerializer.new(object.user).as_json
    end
  end
end
