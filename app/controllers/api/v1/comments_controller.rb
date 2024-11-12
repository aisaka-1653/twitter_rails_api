# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: %i[destroy]

      def create
        @comment = current_api_v1_user.comments.build(comment_params)

        if @comment.save
          head :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        unless @comment.user == current_api_v1_user
          render json: { error: 'Unauthorized' }, status: :forbidden
          return
        end

        if @comment.destroy
          head :no_content
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      private

      def comment_params
        params.require(:comment).permit(:tweet_id, :content)
      end

      def set_comment
        @comment = Comment.find(params[:id])
      end
    end
  end
end
