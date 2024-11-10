# frozen_string_literal: true

module Api
  module V1
    module Users
      class CommentsController < ApplicationController
        before_action :set_user, only: %i[index]

        def index
          @comments = fetch_comments
          render json: @comments, each_serializer: Comments::CommentSerializer
        end

        private

        def set_user
          @user = User.find(params[:user_id])
        end

        def fetch_comments
          @user.comments
               .recent
               .preload(user: { avatar_attachment: :blob })
        end
      end
    end
  end
end
