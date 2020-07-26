class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :authenticate_user!

  add_flash_types :notice, :error, :success

  before_action :set_current_user, if: :user_signed_in?
  before_action :set_paper_trail_whodunnit

  rescue_from ActiveRecord::StaleObjectError, with: :stale_object
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_current_user
    Current.user = current_user
  end

  def stale_object
    flash[:error] = t('optimistic_locked')
    redirect_back(fallback_location: root_path)
  end

  def user_not_authorized
    flash[:error] = t('not_authorized')
    redirect_back(fallback_location: root_path)
  end
end
