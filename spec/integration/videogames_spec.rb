require 'rails_helper'

RSpec.describe 'Videogames', type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { User.new(name: 'Test User', email: 'test@gmail.com', password: '123456', address: 'Test Address') }
  let(:videogame) { Videogame.create(name: 'Videogame test', photo: 'https://photo.jpg', description: 'This is a videogame test description', price_per_day: '5') }

  before(:each) do
    user.save!
    videogame.save!
    sign_in user
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
end
