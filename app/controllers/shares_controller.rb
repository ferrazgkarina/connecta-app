class SharesController < ApplicationController
  before_action :authenticate_user!

  def create
    recipient = User.joins(:profile).find_by(profiles: { username: params[:username]&.strip&.delete("@") })

    if recipient.nil?
      redirect_to event_path(params[:event_id]), alert: "Usuária @#{params[:username]} não encontrada."
      return
    end

    event = Event.find(params[:event_id])
    share = Share.new(sharer: current_user, recipient: recipient, event: event)

    if share.save
      redirect_to event_path(event), notice: "Encontro compartilhado com @#{recipient.profile.username}!"
    else
      redirect_to event_path(event), alert: share.errors.full_messages.to_sentence
    end
  end

  def mark_read
    share = current_user.shares_received.find(params[:id])
    share.update(read: true)
    redirect_to event_path(share.event)
  end
end
