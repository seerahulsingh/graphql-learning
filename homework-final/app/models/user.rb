class User < ApplicationRecord

  has_many :posts
  has_many :sessions

  has_secure_password

  # All users are members :)
  def role
    :member
  end

end
