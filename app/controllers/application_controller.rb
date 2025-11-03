class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  protected
  def after_sign_up_path_for(resource)
    new_profile_path
  end
end
