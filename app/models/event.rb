class Event < ApplicationRecord
  belongs_to :user
  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances, source: :user
  has_many :reviews, dependent: :destroy

  CATEGORIES = ["Cultura e arte", "Esporte", "Comer e beber", "Ao ar livre", "Música e dança", "Bem estar"].freeze
  CONFIRMATION_DEADLINES = ["No mesmo dia", "1 dia antes", "3 dias antes", "1 semana antes"].freeze

  validates :title, :description, :category, :date, :time, presence: true
end
