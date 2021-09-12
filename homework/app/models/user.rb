# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  street          :string
#  number          :string
#  city            :string
#  postcode        :string
#  country         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  email           :string
#  password_digest :string
#  role            :string
#

class User < ApplicationRecord

  has_many :posts, dependent: :destroy
  has_many :sessions, dependent: :destroy

  has_secure_password

  validates :city, presence: true

end
