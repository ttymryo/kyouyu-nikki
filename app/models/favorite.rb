class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :diary
  has_one :activity, as: :subject, dependent: :destroy

  validates :user_id, presence: true
  validates :diary_id, presence: true, uniqueness: {scope: [:user_id]}

  after_create_commit :create_activities

  private

  def create_activities
    Activity.create!(subject: self, user_id: diary.user.id, action_type: Activity.action_types[:favorite])
  end
end
