class Api::V1::ImagekitController < ApplicationController
  def index
    render json: ImageKitIo.client.get_authentication_parameters, status: :ok
  end
end
