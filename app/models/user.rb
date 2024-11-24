class User < ApplicationRecord
    has_many :blogs, dependent: :destroy
    has_many :orders
    has_secure_password
    has_many :refresh_tokens, dependent: :destroy
end
