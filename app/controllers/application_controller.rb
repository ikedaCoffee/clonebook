class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permited_parameters, if: :devise_controller?
  before_action :current_notifications, if: :signed_in?

  def current_notifications
    @notifications_count = Notification.where(user_id: current_user.id).where(read: false).count
  end

  PERMISSIBLE_ATTRIBUTES = %i(name avatar avatar_cache)

  protected
    def configure_permited_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: PERMISSIBLE_ATTRIBUTES)
      devise_parameter_sanitizer.permit(:account_update, keys: PERMISSIBLE_ATTRIBUTES)
    end
end
