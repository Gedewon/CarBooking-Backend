require 'swagger_helper'

RSpec.describe 'api/v1/cars', type: :request do
  path '/api/v1/cars' do
    get('list cars') do
      tags 'Cars'
      response(200, 'successful') do
        example 'application/json', :all_cars, 
          [
              {
                "id": 1,
                "name": "Blue Bmw",
                "image": "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg",
                "amount": 22500,
                "created_at": "2022-11-26T00:23:10.364Z",
                "updated_at": "2022-11-26T00:23:10.364Z"
              },
              {
                "id": 2,
                "name": "Red Alfa Romeo C4 ",
                "image": "https://images.pexels.com/photos/210019/pexels-photo-210019.jpeg",
                "amount": 18500,
                "created_at": "2022-11-26T00:23:10.371Z",
                "updated_at": "2022-11-26T00:23:10.371Z"
              },
              {
                "id": 3,
                "name": "Yellow Chevroelt ",
                "image": "https://images.pexels.com/photos/575386/pexels-photo-575386.jpeg",
                "amount": 37500,
                "created_at": "2022-11-26T00:23:10.377Z",
                "updated_at": "2022-11-26T00:23:10.377Z"
              },
              {
                "id": 4,
                "name": "Black Ferrari",
                "image": "https://images.pexels.com/photos/9596562/pexels-photo-9596562.jpeg",
                "amount": 19600,
                "created_at": "2022-11-26T00:23:10.382Z",
                "updated_at": "2022-11-26T00:23:10.382Z"
              },
              {
                "id": 5,
                "name": "Sports Car",
                "image": "https://images.pexels.com/photos/4674337/pexels-photo-4674337.jpeg",
                "amount": 44700,
                "created_at": "2022-11-26T00:23:10.389Z",
                "updated_at": "2022-11-26T00:23:10.389Z"
              },
              {
                "id": 6,
                "name": "Test car",
                "image": "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg",
                "amount": 22500,
                "created_at": "2022-11-26T17:56:37.104Z",
                "updated_at": "2022-11-26T17:56:37.104Z"
              }
            ]
        run_test!
      end
    end

    post('create car') do
      tags 'Cars'
      consumes 'application/json'
      parameter name: :creat_car, in: :body, schema: {
        type: :object,
        properties: {
          name:{ type: :string},
          image: {type: :string},
          amount: {type: :number}
        },
        required: ['name','password','amount']
      }
      parameter name: :Authorization, in: :header,  type: :string , description: 'Bearer **'
      response(200, 'successful') do
        let(:creat_car){{   "name":"tesla modlex", "image":"https://someimage.png","amount":13433}}
        example 'application/json', :create_car, {
          "id": 9,
          "name": "tesla modlex",
          "image": "https://someimage.png",
          "amount": 13433.0,
          "created_at": "2022-11-28T01:59:26.483Z",
          "updated_at": "2022-11-28T01:59:26.483Z"
       }
        run_test!
      end
      response(401, 'Unauthorized ') do
        let(:Authorization) {'randominvalidbeareretoken'}
        example 'application/json', :unauthorized_logout_request,{
          errors: [
            "translation missing: en.errors.controllers.auth.unauthenticated"
          ]
      }
        run_test!
      end
    end
  end

  path '/api/v1/cars/{id}' do

    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show car') do
      tags 'Cars'
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

    patch('update car') do
      tags 'Cars'

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

    put('update car') do
      tags 'Cars'

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

    delete('delete car') do
      tags 'Cars'

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
