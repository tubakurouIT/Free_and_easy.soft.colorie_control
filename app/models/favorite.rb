class Favorite < ApplicationRecord
  belongs_to :member
  belongs_to :free_post
  
  validates :member_id, uniqueness: {scope: :free_post_id}

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}

end
