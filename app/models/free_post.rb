class FreePost < ApplicationRecord
  has_one_attached :image


  validates :body,presence:true,length:{maximum:200}
  
  belongs_to :member
  belongs_to :group, optional: true

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

end
