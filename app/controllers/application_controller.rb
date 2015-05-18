class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  before_action :authenticate_user!, unless: :pages_controller?

  after_action :verify_authorized, except:  :index, unless: :devise_or_pages_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_or_pages_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def devise_or_pages_controller?
    devise_controller? || pages_controller?
  end

  def after_sign_up_path_for(resource)
    edit_user_path(resource) if request.env['omniauth.origin']
  end

  def after_sign_in_path_for(resource)
    if (request.env['omniauth.origin'] && resource.digicode.nil?
      edit_user_path(resource)
    else
      users_path
    end
  end

  def pages_controller?
    controller_name == "pages"  # Brought by the `high_voltage` gem
  end

  def user_not_authorized
    flash[:error] = I18n.t('controllers.application.user_not_authorized', default: "You can't access this page.")
    redirect_to(root_path)
  end
end
