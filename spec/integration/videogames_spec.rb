require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Videogames', type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { User.create(name: 'Test User', email: 'test@gmail.com', password: '123456', address: 'Test Address', admin: true) }
  let(:videogame) { Videogame.create(name: 'Videogame test', photo: 'https://photo.jpg', description: 'This is a videogame test description', price_per_day: '5') }

  before(:each) do
    user.save!
    videogame.save!
  end


  describe 'GET /index' do
    it 'returns http success' do
      get '/videogames'
      expect(response).to have_http_status(:success)
    end

    it 'shows the videogames' do
      get '/videogames'
      expect(response.body).to include('Videogame test')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/videogames/#{videogame.id}"
      expect(response).to have_http_status(:success)
    end

    it 'shows the videogame' do
      get "/videogames/#{videogame.id}"
      expect(response.body).to include('Videogame test')
    end
  end

  describe 'POST /create' do
    it 'creates a videogame' do
      headers = Devise::JWT::TestHelpers.auth_headers({}, user)
      post('/videogames', params: { videogame: { name: 'New Videogame test', photo: 'https://photo.jpg', description: 'This is a videogame test description', price_per_day: '5' } },
                            headers: headers)

      expect(response).to have_http_status(:success)
      expect(response.body).to include('New Videogame test')
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes a videogame' do
      headers = Devise::JWT::TestHelpers.auth_headers({}, user)
      delete("/videogames/#{videogame.id}", headers: headers)

      expect(response).to have_http_status(:success)
      expect(response.body).to include('Videogame deleted.')
    end
  end
end