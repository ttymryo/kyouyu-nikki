class Activity < ApplicationRecord
  belongs_to :subject, polymorphic: true

  enum action_type: {
    favorite:  0,
    follow:    1,
    comment:   2
  }
end
