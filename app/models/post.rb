class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :member

  validates :title, presence: true
  validates(:body, {presence: true, length: {maximum: 200}})

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
end
