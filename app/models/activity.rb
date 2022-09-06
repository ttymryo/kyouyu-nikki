class Activity < ApplicationRecord
  belongs_to :subject, polymorphic: true

  enum action_type: {
    favorited_the_diary:      0,
    followed_you:             1,
    commented_on_the_diary:   2
  }
end
