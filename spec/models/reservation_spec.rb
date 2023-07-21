require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:user) { User.create(name: 'Test User', email: 'test@gmail.com') }
  subject { Reservation.create(days: '5', total_price: '50', user:) }

  before { subject.save }

  it 'days should be present' do
    subject.days = nil
    expect(subject).to_not be_valid
  end

  it 'total_price should be present' do
    subject.total_price = nil
    expect(subject).to_not be_valid
  end

  it 'days should be integer' do
    subject.days = 'a'
    expect(subject).to_not be_valid
  end

  it 'total_price should be decimal' do
    subject.total_price = 'a'
    expect(subject).to_not be_valid
  end
end
