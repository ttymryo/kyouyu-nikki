class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :diary
  has_one :activity, as: :subject, dependent: :destroy

  validates :user_id, presence: true
  validates :diary_id, presence: true
  validates :body, presence: true, length: { maximum: 500 }

  after_create_commit :create_activities

  private

  def create_activities
    unless diary.user.id == user.id
      Activity.create!(subject: self, user_id: diary.user.id, action_type: Activity.action_types[:comment])
    end
  end
end
