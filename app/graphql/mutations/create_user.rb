# frozen_string_literal: true

module Mutations
  class CreateUser < BaseMutation
    # type(Types::UserType, null: false)
    field(:user, Types::UserType, null: true)
    field(:errors, [String], null: false)
    
    argument :email, String, required: true
    argument :name, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true
    argument :admin, Boolean, required: false

    def resolve(
      email:,
      name:,
      password:,
      password_confirmation:,
      admin: false
    )
      user = ::User.new(
        email: email,
        name: name,
        password: password,
        password_confirmation: password_confirmation,
        admin: admin
      )
      errors = []
      if !user.save()
        errors.append(*user.errors.full_messages)
        user = nil
      end

      return {
        user: user, errors: errors
      }
    end
  end
end
