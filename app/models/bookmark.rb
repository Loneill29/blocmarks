class Bookmark < ApplicationRecord
  belongs_to :topic
  belongs_to :user, optional: true
end
