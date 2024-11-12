# frozen_string_literal: true

module Api
  module V1
    module Tweets
      class RetweetsController < ApplicationController
        def create
          tweet = Tweet.find(params[:tweet_id])

          if current_api_v1_user.retweets.exists?(tweet:)
            return head :unprocessable_entity
          end

          @retweet = current_api_v1_user.retweets.build(tweet:)

          if @retweet.save
            head :created
          else
            render json: @retweet.errors, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
