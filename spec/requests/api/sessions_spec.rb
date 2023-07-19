require 'swagger_helper'

RSpec.describe 'sessions', type: :request do
  path '/users/sign_in' do
    post 'Sign in' do
      tags 'Sign in'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            }
          }
        }
      }

      response '200', 'You are logged in.' do
        let(:user) { { user: { email: 'user@example.com', password: 'password' } } }
        run_test!
      end

      response '401', 'Invalid login credentials.' do
        let(:user) { { user: { email: 'user.example.com', password: 'password' } } }
        run_test!
      end
    end
  end

  path '/users/sign_out' do
    delete 'Sign out' do
      tags 'Sign out'
      security [Bearer: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string

      response '200', 'You are logged out.' do
        let(:user) { { user: { email: 'example@example.com', password: 'password' } } }
        run_test!
      end

      response '401', 'Invalid token.' do
        run_test!
      end
    end
  end
end
