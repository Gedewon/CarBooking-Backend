require 'swagger_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe 'api/v1/registrations', type: :request do
  path '/api/v1/auth/sign_up' do
    post('create registration') do
      tags 'session'
      consumes 'application/json'
      parameter name: :sign_up, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          password: { type: :string },
          email: { type: :string },
          image_url: { type: :string },
          date_of_birth: { type: :date }
        },
        required: %w[name password email image_url date_of_birth]
      }
      response '201', 'user created' do
        let(:sign_up) { { name: 'Gedewon', password: '12346' } }
        header 'Authorization', schema: { type: :string, nullable: true },
                                description: 'Bearer Token that we use to login the user '
        example 'application/json', :successfull_signup, {
          status: 'Created',
          message: 'created users',
          data: {
            id: 1,
            name: 'jon doe',
            created_at: '2022-10-01T23:14:34.994Z',
            updated_at: '2022-10-01T23:14:34.994Z'
          },
          header: {
            Authorization: 'Bearer **'
          }
        }
        run_test!
      end
      response '422', 'failed user creat action ' do
        let(:sign_up) { { name: 'foo' } }
        example 'application/json', :blank_password, {
          status: '422 Unprocessable Entity',
          message: 'Error processing data',
          data: {
            errors: [
              "Password can't be blank"
            ]
          }
        }
        example 'application/json', :blank_name, {
          status: '422 Unprocessable Entity',
          message: 'Error processing data',
          data: {
            errors: [
              "Name can't be blank"
            ]
          }
        }
        example 'application/json', :blanK_body, {
          status: '422 Unprocessable Entity',
          message: 'Error processing data',
          data: {
            errors: [
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
# rubocop:enable Metrics/BlockLength
