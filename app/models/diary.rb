class Diary < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  with_options presence: true do
    validates :user_id
    validates :body
    validates :emotion, numericality: { only_integer: true }
    validates :add_commented
    validates :public_range, numericality: { only_integer: true }
  end

  enum public_range: { myself: 0, in_ff: 1, everyone: 2 }
  enum emotion: { happy: 0, normal: 1, unhappy: 2 }
  enum add_commented: { permission: true, ban: false }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
