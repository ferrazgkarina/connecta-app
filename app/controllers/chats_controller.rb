class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    attended  = current_user.attended_events
    created   = current_user.events
    @events   = (attended + created).uniq.sort_by { |e| e.messages.maximum(:created_at) || e.created_at }.reverse
    current_user.update_column(:messages_last_seen_at, Time.current)
  end
end
