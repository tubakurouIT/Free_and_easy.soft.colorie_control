class Comment < ApplicationRecord
  belongs_to :free_post
  belongs_to :member
  validates :comment,presence:true,length:{maximum:200}
end
