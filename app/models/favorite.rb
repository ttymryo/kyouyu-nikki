class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :diary
  has_one :activity, as: :subject, dependent: :destroy

  validates :user_id, presence: true
  validates :diary_id, presence: true, uniqueness: {scope: [:user_id]}

  after_create_commit :create_activities



  def redirect_path
    "/#{diary.user.name_id}/diaries/#{diary.id}"
  end

  def name
    user.name
  end

  def icon
    "fas fa-heart text-danger"
  end

  private

  def create_activities
    unless diary.user.id == user.id
      Activity.create!(subject: self, user_id: diary.user.id, action_type: Activity.action_types[:favorited_the_diary])
    end
  end

end
