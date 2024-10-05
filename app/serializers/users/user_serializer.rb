# frozen_string_literal: true

module Users
  class UserSerializer < ActiveModel::Serializer
    attributes %i[id display_name username avatar_url]

    delegate :avatar_url, to: :object
  end
end
