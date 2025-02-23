class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :member
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  
  validates(:title, {presence: true, length: {maximum: 100}})
  validates(:body, {presence: true, length: {maximum: 300}})

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
  
end
