class ProfilesController < ApplicationController


  def new
    if current_user.profile.present?
      redirect_to profile_path and return
    end
    @profile = Profile.new
  end

  def create
    @profile = current_user.buld.profile(profile_params)
    if @profile.save
      redirect_to profile_path, notice: "Perfil criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @profile = current_user.profile
  end

  def edit
    @profile = current_user.profile
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
