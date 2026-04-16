class Review < ApplicationRecord
  belongs_to :reviewer, class_name: "User"
  belongs_to :reviewed, class_name: "User"
  belongs_to :event

  validates :rating, presence: true, inclusion: { in: 3..5 }
  validates :reviewer, uniqueness: { scope: :event_id, message: "você já avaliou este encontro" }
  validate :reviewer_is_not_creator
  validate :event_has_ended

  private

  def reviewer_is_not_creator
    errors.add(:base, "Você não pode avaliar seu próprio encontro") if reviewer == reviewed
  end

  def event_has_ended
    errors.add(:base, "O encontro ainda não terminou") if event&.date&.>= Date.today
  end
end
