class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  has_one :activity, as: :subject, dependent: :destroy

  validates :follower_id, presence: true
  validates :followed_id, presence: true, uniqueness: {scope: [:follower_id]}

  after_create_commit :create_activities

  private

  def create_activities
    Activity.create!(subject: self, user_id: followed.id, action_type: Activity.action_types[:follow])
  end
end
