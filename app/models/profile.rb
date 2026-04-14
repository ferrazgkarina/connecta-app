class Profile < ApplicationRecord
  belongs_to :user

  CITIES = ["Rio de Janeiro", "São Paulo", "Belo Horizonte"].freeze
  INTERESTS = ["Cultura e arte", "Esportes", "Comer e beber", "Ao ar livre", "Música e dança", "Bem estar"].freeze

  validates :name, :username, :location, presence: true
  validates :username, uniqueness: true
  validate :max_two_interests

  private

  def max_two_interests
    if interests.present? && interests.length > 2
      errors.add(:interests, "escolha no máximo 2 interesses")
    end
  end
end
