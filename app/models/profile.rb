class Profile < ApplicationRecord
  belongs_to :user

  validates :name, :username, :location, presence: true
  validates :username, uniqueness: true
end
