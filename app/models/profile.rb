class Profile < ApplicationRecord
  belongs_to :user

  validates :username, presence: true
  validates :description, presence: true
  validates :location, presence: true
end
