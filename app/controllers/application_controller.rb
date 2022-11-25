class ApplicationController < ActionController::API
  include AuthenticateRequest
  before_action :current_user
end
