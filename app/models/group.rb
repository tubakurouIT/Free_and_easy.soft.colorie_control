class Group < ApplicationRecord
  has_many :free_posts, dependent: :destroy
  has_many :group_members, dependent: :destroy
  belongs_to :owner, class_name: "Member"
  has_many :members, through: :group_members, source: :member

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image
  

  def get_group_image
    if group_image.attached?
      group_image
    else
      'no_image.jpg'
    end
  end

  def is_owned_by?(member)
    owner.id == member.id
  end


  def include_member?(member)
  group_members.exists?(member_id: member.id)
  end
end

