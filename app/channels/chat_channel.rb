class ChatChannel < ActionCable::Channel::Base
  def subscribed
    event = Event.find_by(id: params[:event_id])
    if event
      stream_from "chat_#{event.id}"
    else
      reject
    end
  end

  def unsubscribed
  end
end
