# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      DEFAULT_LIMIT = 10

      def index
        tweets = fetch_tweets
        render json: {
          tweets: serialize_tweets(tweets),
          has_more: Tweet.count > (offset + limit)
        }
      end

      def create
        @tweet = current_api_v1_user.tweets.build(tweet_params)

        if @tweet.save
          render json: { tweet_id: @tweet.id }, status: :created
        else
          render json: @tweet.errors, status: :unprocessable_entity
        end
      end

      private

      def tweet_params
        params.require(:tweet).permit(:content)
      end

      def serialize_tweets(tweets)
        ActiveModelSerializers::SerializableResource.new(
          tweets,
          each_serializer: Tweets::Index::TweetSerializer
        )
      end

      def fetch_tweets
        Tweet.recent.preload(:user).with_attached_image
             .limit(limit)
             .offset(offset)
      end

      def limit
        (params[:limit] || DEFAULT_LIMIT).to_i
      end

      def offset
        params[:offset].to_i
      end
    end
  end
end
