class Profile < ApplicationRecord
  belongs_to :user

  validates :username, :location, presence: true
  validates :username, uniqueness: true
  belongs_to :user, dependent: :destroy

  validates :username, uniqueness: :true
  validates :username, :location, presence: :true
end
