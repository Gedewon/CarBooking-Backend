class Api::V1::SessionsController < ApplicationController
  include CreateSession

  before_action :authenticate_user, only: %i[validate_token destroy]

  def create
    return error_insufficient_params unless params[:email].present? && params[:password].present?

    @user = User.find_by(email: params[:email])
    return error_invalid_credentials unless @user
    return error_invalid_credentials unless @user.authenticate(params[:password])

    @token = jwt_session_create @user.id
    return error_token_create unless @token

    @token = "Bearer #{@token}"
    success_session_created
  end

  def destroy
    headers = request.headers['Authorization'].split.last
    session = Session.find_by(token: JsonWebToken.decode(headers)[:token])
    session.close
    success_session_destroy
  end

  protected

  def success_session_created
    response.headers['Authorization'] = @token
    render json: @user.as_json(only: %i[id name created_at updated_at image_url email date_of_birth]), status: :created
  end

  def success_session_destroy
    render status: :no_content, json: {}
  end

  def error_invalid_credentials
    render status: :unauthorized, json: { errors: [I18n.t('errors.controllers.auth.invalid_credentials')] }
  end

  def error_token_create
    render status: :unprocessable_entity, json: { errors: [I18n.t('errors.controllers.auth.token_not_created')] }
  end

  def error_insufficient_params
    render status: :unprocessable_entity, json: { errors: [I18n.t('errors.controllers.insufficient_params')] }
  end
end
