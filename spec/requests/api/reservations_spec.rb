require 'swagger_helper'

RSpec.describe 'Reservations API', type: :request do
  path '/reservations' do
    get 'Retrieve all reservations' do
      tags 'Reservations'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string

      response '200', 'Get reservations' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   user_id: { type: :integer },
                   videogame_id: { type: :integer },
                   days: { type: :integer },
                   total_price: { type: :number, format: :float },
                   videogame: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       photo: { type: :string },
                       description: { type: :string },
                       price_per_day: { type: :number, format: :float }
                     },
                     required: [:id, :name]
                   }
                 },
                 required: [:id, :user_id, :videogame_id, :days, :total_price]
               }

        run_test! do |_params, _body, _headers|
          expect(response).to have_http_status(:ok)
        end
      end
    end

    post 'Create a reservation' do
      tags 'Reservations'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          reservation: {
            type: :object,
            properties: {
              videogame_id: { type: :integer },
              days: { type: :integer }
            },
            required: [:videogame_id, :days]
          }
        },
        required: [:reservation]
      }

      response '201', 'Reservation created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 videogame_id: { type: :integer },
                 days: { type: :integer },
                 total_price: { type: :number, format: :float },
                 videogame: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     name: { type: :string },
                     photo: { type: :string },
                     description: { type: :string },
                     price_per_day: { type: :number, format: :float }
                   },
                   required: [:id, :name]
                 }
               },
               required: [:id, :user_id, :videogame_id, :days, :total_price]

        let(:reservation) { { reservation: { videogame_id: 1, days: 3 } } }

        run_test! do |_params, _body, _headers|
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'Unprocessable Entity' do
        let(:reservation) { { reservation: { videogame_id: 1, days: nil } } }

        run_test! do |_params, _body, _headers|
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end