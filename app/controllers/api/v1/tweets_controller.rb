# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      before_action :set_tweet, only: %i[show destroy]

      DEFAULT_LIMIT = 10

      def index
        tweets = fetch_tweets
        render json: {
          tweets: serialize_tweets(tweets),
          has_more: fetch_total_count > (offset + limit)
        }
      end

      def show
        render json: @tweet, serializer: ::Tweets::TweetSerializer
      end

      def create
        @tweet = current_api_v1_user.tweets.build(tweet_params)

        if @tweet.save
          render json: { tweet_id: @tweet.id }, status: :created
        else
          render json: @tweet.errors, status: :unprocessable_entity
        end
      end

      def destroy
        unless @tweet.user == current_api_v1_user
          render json: { error: 'Unauthorized' }, status: :forbidden
          return
        end

        if @tweet.destroy
          head :no_content
        else
          render json: @tweet.errors, status: :unprocessable_entity
        end
      end

      private

      def tweet_params
        params.require(:tweet).permit(:content)
      end

      def set_tweet
        @tweet = Tweet.find(params[:id])
      end

      def serialize_tweets(tweets)
        ActiveModelSerializers::SerializableResource.new(
          tweets,
          each_serializer: ::Tweets::TweetSerializer,
          current_user: current_api_v1_user
        )
      end

      def fetch_tweets
        Tweet
          .left_joins(:retweets)
          .select('tweets.*, COALESCE(retweets.created_at, tweets.created_at) as sort_date')
          .includes(:user, :image_attachment)
          .preload(:comments)
          .distinct
          .order('sort_date DESC')
          .limit(limit)
          .offset(offset)
      end

      def fetch_total_count
        Tweet.left_joins(:retweets)
             .distinct
             .count
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
