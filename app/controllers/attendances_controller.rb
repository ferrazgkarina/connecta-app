class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    @attendance = @event.attendances.build(user: current_user)
    if @attendance.save
      redirect_to @event, notice: "Presença confirmada!"
    else
      redirect_to @event, alert: "Não foi possível confirmar presença."
    end
  end

  def destroy
    @attendance = @event.attendances.find(params[:id])
    @attendance.destroy
    redirect_to @event, notice: "Participação cancelada."
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
