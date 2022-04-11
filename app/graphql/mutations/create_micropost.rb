module Mutations
  class CreateMicropost < BaseMutation
    argument(:content, String, required: true)

    field(:micropost, Types::MicropostType, null: true)
    field(:errors, [String], null: false)

    def resolve(content:)
      micropost = Micropost.new(
        user: context[:signed_in],
        content: content
      )
      errors = []

      if !micropost.save()
        errors.append(*micropost.errors.full_messages)
        micropost = nil
      end

      return {
        micropost: micropost,
        errors: errors
      }
    end
  end
end
