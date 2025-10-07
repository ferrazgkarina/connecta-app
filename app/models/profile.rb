class Profile < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates :username, uniqueness: :true
  validates :username, :location, presence: :true
end
