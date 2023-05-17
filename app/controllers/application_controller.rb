class ApplicationController < ActionController::Base

  before_action :set_account

  def set_account
    @account = Account.find_by(subdomain: request.subdomain)
  end
end
