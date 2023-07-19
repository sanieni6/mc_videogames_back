# rubocop:disable Metrics/BlockLength
require 'swagger_helper'

RSpec.describe 'Videogames API', type: :request do
  path '/videogames' do
    get 'Retrieve all videogames' do
      tags 'Videogames'
      security [Bearer: []]
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string

      response '200', 'Get videogames' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   description: { type: :string },
                   price_per_day: { type: :number, format: :float },
                   photo: { type: :string }
                 },
                 required: %i[id name description price_per_day photo]
               }

        run_test! do |_params, _body, _headers|
          expect(response).to have_http_status(:ok)
        end
      end
    end

    post 'Create a videogame' do
      tags 'Videogames'
      security [Bearer: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :videogame, in: :body, schema: {
        type: :object,
        properties: {
          videogame: {
            type: :object,
            properties: {
              name: { type: :string },
              description: { type: :string },
              price_per_day: { type: :number, format: :float },
              photo: { type: :string }
            },
            required: %i[name description price_per_day photo]
          }
        },
        required: [:videogame]
      }

      response '200', 'Videogame created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :string },
                 price_per_day: { type: :number, format: :float },
                 photo: { type: :string }
               },
               required: %i[id name description price_per_day photo]

        let(:videogame) do
          { videogame: { name: 'Example Game', description: 'Example description', price_per_day: 10.0,
                         photo: 'example.jpg' } }
        end

        run_test! do |_params, _body, _headers|
          expect(response).to have_http_status(:ok)
        end
      end

      response '401', 'You are not authorized to create a videogame.' do
        let(:videogame) do
          { videogame: { name: 'Example Game', description: 'Example description', price_per_day: 10.0,
                         photo: 'example.jpg' } }
        end

        run_test! do |_params, _body, _headers|
          expect(response).to have_http_status(:unauthorized)
        end
      end

      response '422', 'Unprocessable Entity' do
        let(:videogame) do
          { videogame: { name: nil, description: 'Example description', price_per_day: 10.0, photo: 'example.jpg' } }
        end

        run_test! do |_params, _body, _headers|
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  path '/videogames/{id}' do
    get 'Retrieve a specific videogame' do
      tags 'Videogames'
      security [Bearer: []]
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :Authorization, in: :header, type: :string

      response '200', 'Videogame details' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :string },
                 price_per_day: { type: :number, format: :float },
                 photo: { type: :string }
               },
               required: %i[id name description price_per_day photo]

        let(:id) do
          Videogame.create(name: 'Example Game', description: 'Example description', price_per_day: 10.0,
                           photo: 'example.jpg').id
        end

        run_test! do |_params, _body, _headers|
          expect(response).to have_http_status(:ok)
        end
      end

      response '404', 'Not Found' do
        let(:id) { 9999 }

        run_test! do |_params, _body, _headers|
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    delete 'Delete a videogame' do
      tags 'Videogames'
      security [Bearer: []]
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :Authorization, in: :header, type: :string

      response '200', 'Videogame deleted' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               },
               required: [:message]

        let(:id) do
          Videogame.create(name: 'Example Game', description: 'Example description', price_per_day: 10.0,
                           photo: 'example.jpg').id
        end

        run_test! do |_params, _body, _headers|
          expect(response).to have_http_status(:ok)
        end
      end

      response '401', 'You are not authorized to delete a videogame.' do
        let(:id) do
          Videogame.create(name: 'Example Game', description: 'Example description', price_per_day: 10.0,
                           photo: 'example.jpg').id
        end

        run_test! do |_params, _body, _headers|
          expect(response).to have_http_status(:unauthorized)
        end
      end

      response '404', 'Not Found' do
        let(:id) { 9999 }

        run_test! do |_params, _body, _headers|
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
