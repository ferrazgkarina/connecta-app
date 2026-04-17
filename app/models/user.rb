class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :attended_events, through: :attendances, source: :event
  has_one :profile, dependent: :destroy
  has_many :reviews_received, class_name: "Review", foreign_key: :reviewed_id, dependent: :destroy
  has_many :reviews_given, class_name: "Review", foreign_key: :reviewer_id, dependent: :destroy
  has_many :shares_sent, class_name: "Share", foreign_key: :sharer_id, dependent: :destroy
  has_many :shares_received, class_name: "Share", foreign_key: :recipient_id, dependent: :destroy

  def average_rating
    return nil if reviews_received.empty?
    (reviews_received.sum(:rating).to_f / reviews_received.count).round(1)
  end

end
