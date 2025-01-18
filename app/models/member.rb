class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true      

  has_one_attached :profile_image

  has_many :posts, dependent: :destroy
  has_many :free_posts, dependent: :destroy
  has_many :comments, dependent: :destroy
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

end
