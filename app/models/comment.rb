class Comment < ApplicationRecord
  belongs_to :free_post
  belongs_to :member
end
