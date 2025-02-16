class Comment < ApplicationRecord
  belongs_to :free_post
  belongs_to :member

  validates :comment,presence:true,length:{maximum:200}

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  
end
