# frozen_string_literal: true

module Tweets
  class TweetSerializer < ActiveModel::Serializer
    attributes %i[id content image_url created_at user]

    delegate :image_url, to: :object

    def user
      Users::UserSerializer.new(object.user).as_json
    end
  end
end
