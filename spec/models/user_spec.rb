require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Test User', email: 'test@gmail.com', password: '123456', address: 'Test Address', admin: false) }
  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should have a minimum length of 2 characters' do
    subject.name = 'A'
    expect(subject).to_not be_valid
  end

  it 'name should have a maximum length of 50 characters' do
    subject.name = 'a' * 51
    expect(subject).to_not be_valid
  end

  it 'email should be present' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'email should be unique' do
    duplicate_user = subject.dup
    expect(duplicate_user).to_not be_valid
  end

  it 'email should have a maximum length of 50 characters' do
    subject.email = 'a' * 41 + '@example.com'
    expect(subject).to_not be_valid
  end

  it 'email should have a valid format' do
    subject.email = 'invalid_email'
    expect(subject).to_not be_valid
  end

  it 'password should be present' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'password should have a minimum length of 6 characters' do
    subject.password = '12345'
    expect(subject).to_not be_valid
  end

  it 'password should have a maximum length of 20 characters' do
    subject.password = 'a' * 21
    expect(subject).to_not be_valid
  end

  it 'address should be present' do
    subject.address = nil
    expect(subject).to_not be_valid
  end

  it 'address should have a minimum length of 2 characters' do
    subject.address = 'A'
    expect(subject).to_not be_valid
  end

  it 'address should have a maximum length of 255 characters' do
    subject.address = 'a' * 256
    expect(subject).to_not be_valid
  end

  it 'admin should be present' do
    subject.admin = nil
    expect(subject).to_not be_valid
  end
end