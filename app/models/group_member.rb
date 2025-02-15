class GroupMember < ApplicationRecord
  scope :permit, -> { where(status: :permit) }
  scope :application, -> { where(status: :application) }
  scope :rejection, -> { where(status: :rejection) }

  belongs_to :member
  belongs_to :group

  # application=> 申請中
  # permit: 許可済み
  # rejection: 拒否
  enum status: { application: 0, permit: 1, rejection: 2 }
end
