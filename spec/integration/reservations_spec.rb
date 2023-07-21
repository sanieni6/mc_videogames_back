require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { User.new(name: 'Test User', email: 'test@gmail.com', password: '123456', address: 'Test Address') }
  let(:videogame) { Videogame.create(name: 'Videogame test', photo: 'https://photo.jpg', description: 'This is a videogame test description', price_per_day: '5') }
  let!(:reservation) { Reservation.create(days: '5', total_price: '50', user: user, videogame: videogame) }

  before(:each) do
    user.save!
    videogame.save!
    reservation.save!
    sign_in user
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/reservations'
      expect(response).to have_http_status(:success)
    end

    it 'shows the reservation' do
      get '/reservations'
      expect(response.body).to include('Videogame test')
    end
  end
end