# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      def create
        @comment = current_api_v1_user.comments.build(comment_params)

        if @comment.save
          head :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      private

      def comment_params
        params.require(:comment).permit(:tweet_id, :content)
      end
    end
  end
end
