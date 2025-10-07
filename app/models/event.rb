class Event < ApplicationRecord
  belongs_to :user

  validates :title, :description, :category, :date, :time, presence: true
end
