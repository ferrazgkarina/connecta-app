class Share < ApplicationRecord
  belongs_to :sharer, class_name: "User"
  belongs_to :recipient, class_name: "User"
  belongs_to :event

  validates :sharer, :recipient, :event, presence: true
  validates :sharer_id, uniqueness: { scope: [:recipient_id, :event_id], message: "você já compartilhou este encontro com essa pessoa" }
  validate :cannot_share_with_self

  private

  def cannot_share_with_self
    errors.add(:base, "Você não pode compartilhar com você mesma") if sharer == recipient
  end
end
