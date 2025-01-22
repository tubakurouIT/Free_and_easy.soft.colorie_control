class Favorite < ApplicationRecord
  belongs_to :member
  belongs_to :free_post

  validates :member_id, uniqueness: {scope: :free_post_id}
end
