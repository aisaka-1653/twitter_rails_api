# frozen_string_literal: true

module Users
  module Show
    class UserSerializer < ActiveModel::Serializer
      attributes %i[id email display_name username avatar_url header_url bio location website date_of_birth uid]

      delegate :avatar_url, to: :object
      delegate :header_url, to: :object
    end
  end
end
