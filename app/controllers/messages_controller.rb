class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    @message = @event.messages.build(content: params[:content], user: current_user)
    if @message.save
      ActionCable.server.broadcast("chat_#{@event.id}", {
        content:  @message.content,
        username: current_user.profile&.username || current_user.email.split("@").first,
        name:     current_user.profile&.name || current_user.profile&.username,
        time:     @message.created_at.strftime("%H:%M")
      })
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
