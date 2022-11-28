require 'swagger_helper'

RSpec.describe 'api/v1/registrations', type: :request do


  path '/api/v1/auth/sign_up' do
 
    post('create registration') do
      tags 'session'
      consumes 'application/json'
      parameter name: :sign_up, in: :body, schema: {
        type: :object,
        properties: {
          name:{ type: :string},
          password: {type: :string}
        },
        required: ['name','password']
      }
      response '201', 'user created' do 
        let(:sign_up) { { name: 'Gedewon', password: '12346' } }
        header 'Authorization', schema: { type: :string, nullable: true }, description: 'Bearer Token that we use to login the user '
        example 'application/json', :successfull_signup, {
          status: 'Created',
          message: 'created users',
          data: {
            id: 1,
            name: 'jon doe',
            created_at: '2022-10-01T23:14:34.994Z',
            updated_at: '2022-10-01T23:14:34.994Z',
          },
          header:{
            Authorization: "Bearer eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoxMiwidG9rZW4iOiJ4dUFIck43ZGV6N3k1WlBSTXEzb0F1MW5mYVA5ODVLRyIsImV4cCI6MTY2OTY4MTI0NH0.D3J3CnrrX5K4WJMdVmtP5qjWcIHUIqQBAWsGWhi6hy7yZrUju8tzIslhdrXTC5tncOWEA8gADG89NqNeZxU5lg"
          }
        }
        run_test!
      end
      response '422', 'failed user creat action ' do 
        let(:sign_up) { { name: 'foo' } }
        example 'application/json', :blank_password, {
          status: '422 Unprocessable Entity',
          message: 'Error processing data',
          data:{
            "errors": [
               "Password can't be blank"
            ]
         }
        }
        example 'application/json', :blank_name, {
          status: '422 Unprocessable Entity',
          message: 'Error processing data',
          data:{
            "errors": [
              "Name can't be blank"
            ]
         }
        }
        example 'application/json', :blanK_body, {
          status: '422 Unprocessable Entity',
          message: 'Error processing data',
          data:{
            "errors": [
              "Password can't be blank",
              "Name can't be blank"
            ]
         }
        }
        run_test!
      end
    end
  end
end
