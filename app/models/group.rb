class Group < ApplicationRecord
  has_many :free_posts, dependent: :destroy
end
