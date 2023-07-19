# rubocop:disable Metrics/BlockLength
require 'swagger_helper'

RSpec.describe 'api/registrations', type: :request do
  path '/users' do
    post 'Sign up' do
      tags 'Sign up'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string },
              password_confirmation: { type: :string }
            }
          }
        }
      }

      response '200', 'Signed up sucessfully.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 email: { type: :string },
                 name: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 admin: { type: :boolean }
               },
               required: %i[id email name created_at updated_at admin]
        let(:user) do
          { user: { email: 'example@example.com', name: 'example', created_at: '2021-05-05T17:00:00.000Z',
                    updated_at: '2021-05-05T17:00:00.000Z', admin: false } }
        end

        run_test! do |_params, _body, _headers|
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'Something went wrong' do
        run_test!
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
