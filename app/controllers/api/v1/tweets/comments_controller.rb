# frozen_string_literal: true

module Api
  module V1
    module Tweets
      class CommentsController < ApplicationController
        before_action :set_tweet, only: %i[index]

        def index
          @comments = fetch_comments
          render json: @comments, each_serializer: Comments::CommentSerializer
        end

        private

        def set_tweet
          @tweet = Tweet.find(params[:tweet_id])
        end

        def fetch_comments
          @tweet.comments
                .recent
                .preload(user: { avatar_attachment: :blob })
        end
      end
    end
  end
end
