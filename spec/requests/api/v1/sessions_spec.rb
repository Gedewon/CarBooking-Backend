require 'swagger_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe 'api/v1/sessions', type: :request do
  path '/api/v1/auth/sign_in' do
    post('create session') do
      tags 'session'
      consumes 'application/json'
      parameter name: :login, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response(201, 'successful') do
        let(:login) { { email: 'gedewon@gmail.com', password: '12346' } }
        header 'Authorization', schema: { type: :string, nullable: true },
                                description: 'Bearer Token that we will use in other consecutive requests'
        example 'application/json', :successfull_login, {
          data: {
            token: 'Bearer **'
          }
        }
        run_test!
      end

      response(422, 'Unprocessable Entity') do
        let(:login) { { email: 'gedewon@gmail.co' } }
        example 'application/json', :invalid_username_or_password, {
          errors: [
            'translation missing: en.errors.controllers.auth.invalid_credentials'
          ]
        }
        example 'application/json', :missing_username_or_password, {
          errors: [
            'translation missing: en.errors.controllers.insufficient_params'
          ]
        }
        run_test!
      end
    end
  end
  path '/api/v1/auth/validate_token' do
    post('validate token ') do
      tags 'session'
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string,
                description: 'Bearer token to validate if token is valid and doesn\'t expired.'

      response(200, 'Valid token') do
        example 'application/json', :successfull_logout, {
          data: {}
        }
        run_test!
      end
      response(401, 'Unauthorized invalid token ') do
        example 'application/json', :invalid_token, {
          data: {}
        }
        run_test!
      end
    end
  end
  path '/api/v1/auth/sign_out' do
    let(:logout) { {} }
    delete('delete session') do
      tags 'session'
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'Bearer **'
      response(204, 'No Content') do
        example 'application/json', :successfull_logout, {
          data: {}
        }
        run_test!
      end

      response(401, 'Unauthorized ') do
        example 'application/json', :unauthorized_logout_request, {
          errors: [
            'translation missing: en.errors.controllers.auth.unauthenticated'
          ]
        }
        run_test!
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
