# frozen_string_literal: true

module Users
  module Show
    class UserSerializer < ActiveModel::Serializer
      attributes %i[id email display_name username avatar_url header_url bio location website date_of_birth uid following]
      has_many :tweets, serializer: Tweets::TweetSerializer

      delegate :avatar_url, :header_url, to: :object

      def tweets
        object.tweets
              .includes(image_attachment: :blob)
              .order(created_at: :desc)
      end

      def following
        instance_options[:current_user].following?(object)
      end

      def tweet_serializer_options
        { serializer: Tweets::TweetSerializer, scope: instance_options[:current_user] }
      end
    end
  end
end
