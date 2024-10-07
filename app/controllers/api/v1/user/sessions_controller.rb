# frozen_string_literal: true

module Api
  module V1
    module User
      class SessionsController < ApplicationController
        def index
          if current_api_v1_user
            render json: current_api_v1_user, serializer: Users::UserSerializer
          else
            render json: { is_login: false, message: 'ユーザーが存在しません' }
          end
        end
      end
    end
  end
end
