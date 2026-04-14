class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    city = params[:city] || current_user.profile&.location
    @events = Event.all
    @events = @events.where(city: city) if city.present?
    @events = @events.where(category: params[:category]) if params[:category].present?
    @events = @events.order(:date)
  end

  def confirmed
    attended = current_user.attended_events
    created = current_user.events
    @events = (attended + created).uniq.sort_by(&:date)
    @events_by_date = @events.group_by(&:date)
    @current_month = params[:month] ? Date.parse(params[:month]) : Date.today.beginning_of_month
  end

  def show
    @attendance = @event.attendances.find_by(user: current_user)
    @related_events = Event.where(category: @event.category).where.not(id: @event.id).limit(4)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: "Encontro criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Encontro atualizado!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Encontro apagado com sucesso"
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :category, :date, :time, :duration, :address, :city, :costs, :confirmation_deadline)
  end
end
