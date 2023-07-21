require 'rails_helper'

RSpec.describe Videogame, type: :model do
  subject { Videogame.create(name: 'Videogame test', photo: 'https://photo.jpg', description: 'This is a videogame test description', price_per_day: '5') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'photo should be present' do
    subject.photo = nil
    expect(subject).to_not be_valid
  end

  it 'description should be present' do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it 'price_per_day should be present' do
    subject.price_per_day = nil
    expect(subject).to_not be_valid
  end
end
