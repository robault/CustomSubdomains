class ApplicationController < ActionController::Base

  before_action :set_account
  before_action :configure_permitted_parameters, if: :devise_controller?

    private

    def configure_permitted_parameters
      #devise_parameter_sanitizer.for(:sign_up) { |u|
      #  u.permit(:email, :password, :password_confirmation, account_attributes: [:subdomain])
      #}
      devise_parameter_sanitizer.permit(:sign_up, keys: [:account_attributes => [:subdomain]])
    end

  def set_account
    @account = Account.find_by(subdomain: request.subdomain)
  end
end
