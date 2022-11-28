class Api::V1::RegistrationsController < ApplicationController
  include CreateSession

  def create
    @user = User.new(registration_params)

    if @user.save
      @token = jwt_session_create @user.id
      return error_token_create unless @token

      @token = "Bearer #{@token}"
      success_user_created

    else
      error_user_save
    end
  end

  protected

  def success_user_created
    response.headers['Authorization'] = @token
    render json: @user.as_json(only: %i[id name created_at updated_at]), status: :created
  end

  def error_token_create
    render status: :unprocessable_entity, json: { errors: [I18n.t('errors.controllers.auth.token_not_created')] }
  end

  def error_user_save
    render status: :unprocessable_entity, json: { errors: @user.errors.full_messages }
  end

  private

  def registration_params
    params.permit(:name, :password)
  end
end
