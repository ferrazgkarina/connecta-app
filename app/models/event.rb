class Event < ApplicationRecord
  belongs_to :user
  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances, source: :user
  has_many :reviews, dependent: :destroy

  CATEGORIES = ["Cultura e arte", "Esporte", "Comer e beber", "Ao ar livre", "Música e dança", "Bem estar"].freeze
  CONFIRMATION_DEADLINES = ["Até 3 dias antes", "Até 24 horas antes", "Até 8 horas antes", "Até 4 horas antes"].freeze

  validates :title, :description, :category, :date, :time, presence: true
end
