class FreePost < ApplicationRecord
  has_one_attached :image


  validates :body,presence:true,length:{maximum:200}
  
  belongs_to :member
  belongs_to :group, optional: true
  has_many :comments, dependent: :destroy
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  
   
    def self.search_for(content, method)
      if method == 'perfect'
        FreePost.where(title: content)
      elsif method == 'forward'
        FreePost.where('body LIKE ?', content + '%')
      elsif method == 'backward'
        FreePost.where('body LIKE ?', '%' + content)
      else
        FreePost.where('body LIKE ?', '%' + content + '%')
      end
    end
    

end
