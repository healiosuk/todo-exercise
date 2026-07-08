class Todo < ApplicationRecord
  PRIORITIES = %w[low medium high].freeze

  belongs_to :user

  validates :title, presence: true
end
