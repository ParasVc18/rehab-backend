class User < ApplicationRecord
    before_create -> { self.auth_token = SecureRandom.hex }
    has_many :posts
    has_many :comments
    has_many :likes
    has_many :poisons
    has_many :stats
end
