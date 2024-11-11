# frozen_string_literal: true

module Comments
  class CommentSerializer < ActiveModel::Serializer
    attributes %i[id content user]

    def user
      Users::UserSerializer.new(object.user).as_json
    end
  end
end
