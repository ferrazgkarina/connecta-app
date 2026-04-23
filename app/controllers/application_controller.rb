class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_unread_messages_count, if: :user_signed_in?

  private

  def set_unread_messages_count
    event_ids = (current_user.attended_events.pluck(:id) + current_user.events.pluck(:id)).uniq
    since = current_user.messages_last_seen_at || 1.year.ago
    @unread_messages_count = Message
      .where(event_id: event_ids)
      .where.not(user: current_user)
      .where("created_at > ?", since)
      .count
  end
end
