# frozen_string_literal: true

module Api
  module V1
    module Tweets
      class LikesController < ApplicationController
        before_action :set_tweet, only: %i[create destroy]

        def create
          return head :unprocessable_entity if current_api_v1_user.likes.exists?(tweet: @tweet)

          @like = current_api_v1_user.likes.build(tweet: @tweet)

          if @like.save
            head :created
          else
            render json: @like.errors, status: :unprocessable_entity
          end
        end

        def destroy
          like = current_api_v1_user.likes.find_by(tweet: @tweet)

          return head :not_found if like.nil?

          like.destroy!
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
