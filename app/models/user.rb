class User < ApplicationRecord
    has_many(:microposts, dependent: :destroy)
    has_many(:active_relationships, class_name: "Relationship",
        foreign_key: "follower_id",
        dependent: :destroy
    )
    has_many(:passive_relationships, class_name: "Relationship",
        foreign_key: "followed_id",
        dependent: :destroy
    )
    has_many(:following, through: :active_relationships, source: :followed)
    has_many(:followers, through: :passive_relationships, source: :follower)

    validates(
        :email,
        presence: true,
        uniqueness: true,
        format: {
            with: URI::MailTo::EMAIL_REGEXP
        }
    )

    validates(
        :name,
        presence: true,
        length: {
            maximum: 100
        }
    )

    validates(
        :password,
        presence: true,
        confirmation: true,
        length: {
            minimum: 6,
            maximum: 100
        }
    )

    before_save() do
        self.email = self.email.downcase()
    end

    has_secure_password()
end
