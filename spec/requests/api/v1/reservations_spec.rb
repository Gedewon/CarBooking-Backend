require 'swagger_helper'

RSpec.describe 'api/v1/reservations', type: :request do

  path '/api/v1/reservations' do

    get('list reservations') do
      tags 'Reservation'
      consumes 'application/json'
      parameter name: :Authorization , in: :header, type: :string,  description: 'Bearer **'
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(401, 'Unauthorized') do
        let(:Authorization) {{Authorization:'some invalid test'}}
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create reservation') do
      tags 'Reservation'
      consumes 'application/json'
      parameter name: :Authorization , in: :header, type: :string,  description: 'Bearer **'
      parameter name: :creat_resrvation, in: :body, schema: {
        type: :object,
        properties: {
          car_id:{ type: :number},
          start_date: {type: :string},
          end_date: {type: :string},
          city: {type: :string},
        },
        required: ['car_id','start_date','end_date','city']
      }
      response(201, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(401, 'Unauthorized') do
        let(:Authorization){{Authorization:'someInvalidAuthToken'}}
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/reservations/{id}' do
    get('show reservation') do
      tags 'Reservation'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :Authorization , in: :header, type: :string, required: true, description: 'Bearer **'
      response(200, 'successful') do
        let(:id) { '2' }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(404, 'Not Found') do
        let(:id) { '2' }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(401, 'Unauthorized') do
        let(:Authorization) { 'someInvalidToken' }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch('update reservation') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update reservation') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete reservation') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end