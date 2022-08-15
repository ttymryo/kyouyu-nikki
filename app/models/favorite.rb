class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :diary

  validates :user_id, presence: true
  validates :diary_id, presence: true, uniqueness: {scope: [:user_id]}
end
