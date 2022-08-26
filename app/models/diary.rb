class Diary < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum public_range: { myself: 0, in_ff: 1, everyone: 2 }
  enum emotion: { happy: 0, normal: 1, unhappy: 2 }
  enum add_commented: { permission: true, ban: false }

  with_options presence: true do
    validates :user_id
    validates :body
    validates :emotion, inclusion: { in: Diary.emotions.keys }
    validates :public_range, inclusion: {in: Diary.public_ranges_i18n.keys}
    validates :add_commented, inclusion: {in: Diary.add_commenteds.keys}
  end


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(word)
    @diary = Diary.where('body LIKE?', "%#{word}%")
    return @diary
  end

end
