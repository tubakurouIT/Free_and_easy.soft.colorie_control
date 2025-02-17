class Member < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true      

  has_one_attached :profile_image

  has_many :posts, dependent: :destroy
  has_many :free_posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_members, dependent: :destroy
  has_many :groups, through: :group_members
  has_many :favorites, dependent: :destroy
  has_many :favorite_free_posts, through: :favorites, source: :free_post 
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}

  GUEST_MEMBER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_MEMBER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "guest"
      member.introduction = "This is a guest account."
    end
  end
  
  def guest_member?
    email == GUEST_MEMBER_EMAIL
  end

  #退会済みのユーザーを判別
  def active_for_authentication?
    super && (is_active == true)
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Member.where(name: content)
    elsif method == 'forward'
      Member.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Member.where('name LIKE ?', '%' + content)
    else
      Member.where('name LIKE ?', '%' + content + '%')
    end
  end

  def join_group(group)
    self.group_members.find_or_create_by(group: group)
  end

  def reject_group(group)
    self.group_members.find_by(group: group)&.destroy
  end

  def join_group?(group)
    self.groups.include?(group)
  end

  def favorite(free_post)
    self.favorites.find_or_create_by(free_post: free_post)
  end

  def unfavorite(free_post)
    self.favorites.find_by(free_post: free_post)&.destroy
  end

  def favorite?(free_post)
    self.favorite_free_posts.include?(free_post)
  end

  def permit_groups
    Group.joins(:group_members).where(
      'group_members.status': :permit,
      'group_members.member_id': self.id
    ).or(
      Group.where(
        owner_id: self.id
      )
    ).distinct
  end
  
end
