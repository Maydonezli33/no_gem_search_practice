class Cooking < ApplicationRecord
  belongs_to :user
  belongs_to :genre

  validates :title, presence: true
  validates :content, presence: true
  validates :genre_id, presence: true
end