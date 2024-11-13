# frozen_string_literal: true

module Api
  module V1
    module Tweets
      class RetweetsController < ApplicationController
        before_action :set_tweet, only: %i[create destroy]

        def create
          if current_api_v1_user.retweets.exists?(tweet: @tweet)
            return head :unprocessable_entity
          end

          @retweet = current_api_v1_user.retweets.build(tweet: @tweet)

          if @retweet.save
            head :created
          else
            render json: @retweet.errors, status: :unprocessable_entity
          end
        end

        def destroy
          retweet = current_api_v1_user.retweets.find_by(tweet: @tweet)

          if retweet.nil?
            return head :not_found
          end

          retweet.destroy!
          head :no_content
        end

        private 

        def set_tweet
          @tweet = Tweet.find(params[:tweet_id])
        end
      end
    end
  end
end
