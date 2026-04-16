class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update]

  def new
    if current_user.profile.present?
      redirect_to profile_path and return
    end

    @profile = current_user.build_profile
  end

  def create
    if current_user.profile.present?
      redirect_to profile_path, alert: "Você já tem um perfil criado" and return
    end

    @profile = current_user.build_profile(profile_params)

    if @profile.save
      redirect_to profile_path, notice: "Perfil criado com sucesso!"

    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    interests = current_user.profile&.interests&.compact_blank || []
    city = current_user.profile&.location

    scope = Event.where.not(user: current_user).where(city: city)
    scope = scope.where(category: interests) if interests.any?
    scope = scope.where("date >= ?", params[:date]) if params[:date].present?

    @nearby_events = scope.order(:date).limit(6)
    @my_events = current_user.events.order(:date)

    reviewed_event_ids = current_user.reviews_given.pluck(:event_id)
    @pending_reviews = current_user.attended_events
                                   .where("date < ?", Date.today)
                                   .where.not(user: current_user)
                                   .where.not(id: reviewed_event_ids)
                                   .order(:date)
                                   .limit(3)
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path, notice: "Perfil atualizado com sucesso"
    else
      render :edit, status: :unprocessable_entity
    end
  end

    private

    def set_profile
      @profile = current_user.profile
    end

    def profile_params
      permitted = params.require(:profile).permit(:name, :username, :description, :location, :picture, interests: [])
      permitted[:interests] = permitted[:interests]&.reject(&:blank?) if permitted[:interests]
      permitted
    end
end
