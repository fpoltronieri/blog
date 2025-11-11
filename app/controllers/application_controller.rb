class ApplicationController < ActionController::Base
  include Authentication
  before_action :set_current_session
  helper_method :current_user

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def set_current_session
    Current.session = Session.find_by(id: cookies.signed[:session_id])
  end

  def current_user = Current.user

end
