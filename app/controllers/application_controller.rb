# frozen_string_literal: true

class ApplicationController < ActionController::API
    include AuthenticateRequest
    before_action :current_user
end
