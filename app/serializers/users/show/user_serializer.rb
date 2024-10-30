# frozen_string_literal: true

module Users
  module Show
    class UserSerializer < ActiveModel::Serializer
      attributes %i[id email display_name username avatar_url header_url bio location website date_of_birth uid]
      has_many :tweets, serializer: Tweets::TweetSerializer

      delegate :avatar_url, to: :object
      delegate :header_url, to: :object

      def tweets
        object.tweets
              .includes(image_attachment: :blob)
              .order(created_at: :desc)
      end
    end
  end
end
