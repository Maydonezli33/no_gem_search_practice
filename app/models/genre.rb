class Genre < ApplicationRecord
  has_many :cookings, dependent: :restrict_with_error

  validates :name, presence: true
end