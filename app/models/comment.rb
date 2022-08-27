class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :diary

  validates :user_id, presence: true
  validates :diary_id, presence: true
  validates :body, presence: true, length: { maximum: 500 }
end
