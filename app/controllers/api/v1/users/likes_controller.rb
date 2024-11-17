# frozen_string_literal: true

module Api
  module V1
    module Users
      class LikesController < ApplicationController
        before_action :set_user, only: %i[index]

        def index
          @likes = fetch_likes
          render json: @likes, each_serializer: ::Tweets::TweetSerializer, current_user: current_api_v1_user
        end

        private

        def set_user
          @user = User.find(params[:user_id])
        end

        def fetch_likes
          @user.liked_tweets
               .includes(:user, :image_attachment)
               .preload(:comments)
        end
      end
    end
  end
end
