class Diary < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum public_renge: { myself: 0, in_ff: 1, everyone: 2 }
  enum emotion: { happy: 0, normal: 1, unhappy: 2 }

end
