class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    @attendance = @event.attendances.build(user: current_user)
    if @attendance.save
      redirect_to confirmed_events_path, notice: "Presença confirmada! O encontro foi adicionado à sua agenda."
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
