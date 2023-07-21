require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Reservations', type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { User.create(name: 'Test User', email: 'test@gmail.com', password: '123456', address: 'Test Address') }
  let(:videogame) { Videogame.create(name: 'Videogame test', photo: 'https://photo.jpg', description: 'This is a videogame test description', price_per_day: 5) }
  let!(:reservation) { Reservation.create(days: 5, total_price: 25, user:, videogame:) }

  before(:each) do
    user.save!
    videogame.save!
    sign_in user
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/reservations'
      expect(response).to have_http_status(:success)
    end

    it 'shows the reservation' do
      get '/reservations'
      expect(response).to have_http_status(:success)
      expect(response.body).to include(videogame.name)
    end
  end

  describe 'POST /create' do
    it 'creates a reservation' do
      headers = Devise::JWT::TestHelpers.auth_headers({}, user)
      post('/reservations', params: { reservation: { videogame_id: videogame.id, days: 5, total_price: 25 } },
                            headers:)

      expect(response).to have_http_status(:created)
      expect(response.body).to include(reservation.days.to_s)
    end
  end
end
