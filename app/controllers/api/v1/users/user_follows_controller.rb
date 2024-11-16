# frozen_string_literal: true

module Api
  module V1
    module Users
      class UserFollowsController < ApplicationController
        before_action :set_user, only: %i[create]
        before_action :check_self_follow, only: %i[create]

        def create
          current_api_v1_user.follow(@user)
          head :created
        rescue ActiveRecord::RecordInvalid
          render json: { error: "フォローできませんでした" }, status: :unprocessable_entity
        end

        private

        def set_user
          @user = User.find(params[:user_id])
        end

        def check_self_follow
          if @user == current_api_v1_user
            render json: { error: "自分自身をフォローすることはできません"}, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
