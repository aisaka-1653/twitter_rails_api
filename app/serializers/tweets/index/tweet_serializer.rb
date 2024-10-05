# frozen_string_literal: true

module Tweets
  module Index
    class TweetSerializer < ActiveModel::Serializer
      attributes %i[id content image_url]

      delegate :image_url, to: :object
      belongs_to :user, serializer: Users::UserSerializer
    end
  end
end
