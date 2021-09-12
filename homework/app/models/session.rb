# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  key        :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Session < ApplicationRecord

  belongs_to :user

  before_create do
    self.key = SecureRandom.hex(20)
  end

end
