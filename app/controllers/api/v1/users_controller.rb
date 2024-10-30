# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show]

      def show
        render json: @user, serializer: Users::Show::UserSerializer
      end

      def update
        if current_api_v1_user.update(user_params)
          head :ok
        else
          render json: { error: 'プロフィールの更新に失敗しました' }, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:display_name, :bio, :location, :website, :avatar, :header)
      end
    end
  end
end
