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
  end

  def edit
  end

  def update
    if profile.update(profile_params)
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
      params.require(:profile).permit(:username, :description, :location, :interests, :picture)
    end
end
