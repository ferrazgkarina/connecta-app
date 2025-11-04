class ProfilesController < ApplicationController


  def new
    if current_user.profile.present?
      redirect_to profile_path(current_user.profile) and return
    end

    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      redirect_to profile_path(@profile), notice: "Perfil criado com sucesso!"
    else
      Rails.logger.info "ERROS DO PROFILE: #{@profile.errors.full_messages.to_sentence}"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @profile
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
      params.require(:profile).permit(:username, :description, :location, :interests)
    end
end
