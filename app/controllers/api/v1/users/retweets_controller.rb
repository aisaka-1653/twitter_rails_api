# frozen_string_literal: true

module Api
  module V1
    module Users
      class RetweetsController < ApplicationController
        before_action :set_user, only: %i[index]

        def index
          @retweets = fetch_retweets
          render json: @retweets, each_serializer: ::Tweets::TweetSerializer, current_user: current_api_v1_user
        end

        private

        def set_user
          @user = User.find(params[:user_id])
        end

        def fetch_retweets
          @user.retweeted_tweets
               .includes(:user, :image_attachment)
               .preload(:comments)
        end
      end
    end
  end
end
