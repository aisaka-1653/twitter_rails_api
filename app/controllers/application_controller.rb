# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_api_v1_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  include DeviseTokenAuth::Concerns::SetUserByToken

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username display_name date_of_birth])
  end
end
