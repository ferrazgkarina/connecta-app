class Profile < ApplicationRecord
  belongs_to :user

  validates :username, :location, presence: true
  validates :username, uniqueness: true
end
