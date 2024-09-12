# frozen_string_literal: true

module Api
  module V1
    class ImagesController < ApplicationController
      def create
        @tweet = Tweet.find(params[:tweet_id])
        begin
          @tweet.image.attach(params[:image])
          @tweet.save!
          head :created
        rescue ActiveRecord::RecordInvalid
          @tweet.destroy
          render json: { error: 'ツイートに失敗しました' }, status: :unprocessable_entity
        end
      end

      private

      def image_params
        params.require(:image).permit(:tweet_id, :image)
      end
    end
  end
end
