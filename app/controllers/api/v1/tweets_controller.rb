# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      def index
        @tweets = Tweet.preload(:user).with_attached_image.order(created_at: :desc)
        render json: @tweets, each_serializer: Tweets::Index::TweetSerializer
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
    end
  end
end
