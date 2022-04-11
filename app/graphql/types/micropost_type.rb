# frozen_string_literal: true

module Types
  class MicropostType < Types::BaseObject
    field :id, ID, null: false
    field :user, UserType, null: true, method: :user
    field :content, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
