class User < ApplicationRecord
  has_many :todos, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end
end
