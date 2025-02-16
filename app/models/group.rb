class Group < ApplicationRecord
  has_many :free_posts, dependent: :destroy
  has_many :group_members, dependent: :destroy
  has_one_attached :group_image
  has_many :members, through: :group_members, source: :member
  belongs_to :owner, class_name: "Member"

  validates :name, presence: true
  validates :introduction, presence: true
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}

  def self.search_for(content, method)
    if method == 'perfect'
      Group.where(name: content)
    elsif method == 'forward'
      Group.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Group.where('name LIKE ?', '%' + content)
    else
      Group.where('name LIKE ?', '%' + content + '%')
    end
  end

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

