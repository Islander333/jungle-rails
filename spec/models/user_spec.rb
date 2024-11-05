require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'is invalid without a password' do
    user = User.new(
      password: nil,
      password_confirmation: 'password',
      email: 'test@example.com',
      first_name: 'First',
      last_name: 'Last'
      )
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include ("Password can't be blank")
  end

  it 'is invalid without a password confirmation' do
    user = User.new(
      password: 'password',
      password_confirmation: nil,
      email: 'test@example.com',
      first_name: 'First',
      last_name: 'Last'
      )
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include ("Password confirmation can't be blank")
  end

  it 'is invalid when password and password confirmation do not match' do
    user = User.new(
      password: 'password',
      password_confirmation: 'otherpassword',
      email: 'test@example.com',
      first_name: 'First',
      last_name: 'Last'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include ("Password confirmation doesn't match Password")
  end

  it 'is invalid when the password is too short' do
  user = User.new(
      password: 'pass',
      password_confirmation: 'pass',
      email: 'test@example.com',
      first_name: 'First',
      last_name: 'Last'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include ("Password is too short (minimum is 6 characters)")
  end

  it 'is valid when the password meets the minimum length' do
  user = User.new(
      password: 'password',
      password_confirmation: 'password',
      email: 'test@example.com',
      first_name: 'First',
      last_name: 'Last'
      )
      expect(user).to be_valid
  end

  it 'is invalid without an email' do
    user = User.new(
        password: 'password',
        password_confirmation: 'password',
        email: nil,
        first_name: 'First',
        last_name: 'Last'
        )
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include ("Email can't be blank")
    end


    it 'is invalid without a first name' do
      user = User.new(
          password: 'password',
          password_confirmation: 'password',
          email: 'test@example.com',
          first_name: nil,
          last_name: 'Last'
          )
          expect(user).not_to be_valid
          expect(user.errors.full_messages).to include ("First name can't be blank")
      end

      it 'is invalid without a last name' do
        user = User.new(
            password: 'password',
            password_confirmation: 'password',
            email: 'test@example.com',
            first_name: 'first',
            last_name: nil
            )
            expect(user).not_to be_valid
            expect(user.errors.full_messages).to include ("Last name can't be blank")
        end
  end


  describe '.authenticate_with_credentials' do
    before do
        @user = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User'
      )
      puts @user.errors.full_messages unless @user.valid? 
    end
  
    it 'authenticates with valid credentials' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'returns nil with incorrect password' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    it 'returns nil for a non-existent email' do
      authenticated_user = User.authenticate_with_credentials('nonexistent@example.com', 'password')
      expect(authenticated_user).to be_nil
    end

    it 'authenticates with upper case email' do
      authenticated_user = User.authenticate_with_credentials('TEST@EXAMPLE.COM', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'authenticates with email containing leading and trailing spaces' do
      authenticated_user = User.authenticate_with_credentials('   test@example.com   ', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'authenticates with email containing spaces and mixed case' do
      authenticated_user = User.authenticate_with_credentials('   tEsT@eXample.COM   ', 'password')
      expect(authenticated_user).to eq(@user)
    end

  end
end
