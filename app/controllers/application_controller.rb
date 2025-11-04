class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  def after_sign_in_path_for(resource)
    next_path_after_auth(resource)
  end

  def after_sign_up_path_for(resource)
    next_path_after_auth(resource)
  end

  private

  def next_path_after_auth(user)
    if user.profile.present?
      # se já tem perfil, manda pro dashboard
      # pode ser profile_path(user.profile) ou dashboard_path, como preferir
      profile_path(user.profile)
    else
      # se não tem perfil, manda criar
      new_profile_path
    end
  end
end
