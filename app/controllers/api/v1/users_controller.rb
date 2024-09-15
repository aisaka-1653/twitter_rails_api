# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user

      def show
        render json: @user, serializer: Users::Show::UserSerializer
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
