module Mutations
  class CreateSession < BaseMutation
    argument(:email, String, required: true)
    argument(:password, String, required: true)

    field(:user, Types::UserType, null: true)
    field(:token, String, null: true)
    field(:errors, [String], null: false)

    def resolve(email:, password:)
      user = User.find_by(email: email)
      token = nil
      errors = []

      if user
        if user.authenticate(password)
          crypt = ActiveSupport::MessageEncryptor.new(
            Rails.application.credentials.secret_key_base.byteslice(0..31)
          )
          token = crypt.encrypt_and_sign(user.id.to_s)

          context[:session][:token] = token
        else
          user = nil
          errors.append("Password is incorrect")
        end
      else
        user = nil
        errors.append("Email does not exist")
      end

      return {
        user: user,
        token: token,
        errors: errors
      }
    end
  end
end
