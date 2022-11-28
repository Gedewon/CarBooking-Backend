require 'swagger_helper'

RSpec.describe 'api/v1/sessions', type: :request do

  path '/api/v1/auth/sign_in' do

    post('create session') do
      tags "Login"
      consumes 'application/json'
      parameter name: :login, in: :body, schema: {
        type: :object,
        properties: { 
          name: {type: :string},
          password: {type: :string}
        },
        required: ['name','password']
      }

      response(200, 'successful') do
        let(:login) { { name: 'Gedewon', password: '12346' } }
        header 'Authorization', schema: { type: :string, nullable: true }, description: 'Bearer Token that we will use in other consecutive requests'
        example 'application/json', :successfull_login, {
          data: {
              token: "Bearer eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjozLCJ0b2tlbiI6Ino1VDZQTWdUY2Y3TERtRmlwSG5TM3pTUFphU3dRWHlFIiwiZXhwIjoxNjY5NjgzMzc2fQ.8E9DtWViDxWW_QG7YHqb76_W69Ew02ovTdL26YM2DBmkdw8Px0amiGFrRJnqcZSiKAYJuAVsn43JmOlmWtaPRQ"
          }
        }
        run_test!
      end

      response(422, 'Unprocessable Entity') do
        let(:login) { { name: 'Gedewon' } }
        example 'application/json', :invalid_username_or_password, {
            errors: [
               "translation missing: en.errors.controllers.auth.invalid_credentials"
            ]
        }
        example 'application/json', :missing_username_or_password,{
          errors: [
            "translation missing: en.errors.controllers.insufficient_params"
          ]
      }
        run_test!
      end
    end
  end

  path '/api/v1/auth/sign_out' do
    let(:logout) { {  } }
    delete('delete session') do
      tags "Log out"
      consumes 'application/json'
      parameter name: :logout, in: :headers, schema: {
        type: :object,
        properties: { 
          Authorization: {type: :string},
        },
        required: ['Authorization']
      }
      response(204, 'No Content') do
        example 'application/json', :successfull_logout, {
          data: {
          }
        }
        run_test!
      end

      response(401, 'Unauthorized ') do
        example 'application/json', :unauthorized_logout_request,{
          errors: [
            "translation missing: en.errors.controllers.auth.unauthenticated"
          ]
      }
        run_test!
      end
    end
  end
end