class FreePost < ApplicationRecord
  has_one_attached :image


  validates :body,presence:true,length:{maximum:200}
  
  belongs_to :member
end
