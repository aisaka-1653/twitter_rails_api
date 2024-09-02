# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      def index
        render json: { name: 'example' }
      end
    end
  end
end
