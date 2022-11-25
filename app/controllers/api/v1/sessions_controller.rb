class Api::V1::SessionsController < ApplicationController
  include CreateSession
  
  before_action :authenticate_user, only: [:validate_token, :destroy]
  
  def create
    return error_insufficient_params unless params[:name].present? && params[:password].present?
    @user = User.find_by(name: params[:name])
    if @user
      if @user.authenticate(params[:password])
        @token = jwt_session_create @user.id
        if @token
          @token = "Bearer #{@token}"
          return success_session_created
        else
          return error_token_create
        end
      else
        return error_invalid_credentials
      end
    else
      return error_invalid_credentials
    end
  end


  def destroy
    headers = request.headers['Authorization'].split(' ').last
    session = Session.find_by(token: JsonWebToken.decode(headers)[:token])
    session.close
    success_session_destroy
  end

  protected

  def success_session_created
    response.headers['Authorization'] = @token
    render json:{token:@token}, status: :created
  end


  def success_session_destroy
    render status: :no_content, json: {}
  end

  def error_invalid_credentials
    render status: :unauthorized, json: {errors: [I18n.t('errors.controllers.auth.invalid_credentials')]}
  end

  def error_token_create
    render status: :unprocessable_entity, json: {errors: [I18n.t('errors.controllers.auth.token_not_created')]}
  end

  def error_insufficient_params
    render status: :unprocessable_entity, json: {errors: [I18n.t('errors.controllers.insufficient_params')]}
  end
end
