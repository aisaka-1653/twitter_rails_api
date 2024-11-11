# frozen_string_literal: true

module Api
  module V1
    module Tweets
      class RetweetsController < ApplicationController
        def create
          @retweet = current_api_v1_user.retweets.build(retweet_params)

          if @retweet.save
            head :created
          else
            render json: @retweet.errors, status: :unprocessable_entity
          end
        end

        private

        def retweet_params
          params.require(:retweet).permit(:tweet_id)
        end
      end
    end
  end
end
