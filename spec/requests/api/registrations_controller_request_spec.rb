require 'rails_helper'
require './spec/support/authentication_helper'

RSpec.configure do |c|
  c.include AuthenticationHelpers
end

RSpec.describe "Api::RegistrationsControllers", type: :request do

  before (:each) do
    create_fake_user
  end

  context 'signing up' do

    before (:each) do
      @user = {
        email:      'test1@test.com',
        first_name: 'FakeFirstName',
        last_name:  'FakeLastName',
        born_date:  13.years.ago,
        address:    'Fake Street 123', 
        password:   '12345678',
        password_confirmation: '12345678'
      }
    end

    it 'user email field has to be completed' do
      @user[:email] = ''
      json_sign_up @user
      expect(response).to have_http_status(422)
    end

    it 'user email has to be unique' do
      @user[:email] = 'test@test.com'
      json_sign_up @user
      expect(response).to have_http_status(422)
    end

    it 'user password has to be greather or equal than 6' do
      @user[:password] = '1234'
      @user[:password_confirmation] = '1234'
      json_sign_up @user
      expect(response).to have_http_status(422)
    end

    it 'user password has to be confirmated' do
      @user[:password] = '123456'
      @user[:password_confirmation] = '12345678'
      json_sign_up @user
      expect(response).to have_http_status(422)
    end

    it 'with unique email and password with password confirmation' do
      json_sign_up @user
      expect(response).to have_http_status(201)
    end
  end

  context 'edit password' do

    before (:each) do
      @user = {
        current_password: '123456',
        password: '12345678',
        password_confirmation: '12345678'
      }

      @headers = {
        email: User.first.email,
        token: User.first.authentication_token
      }
    end

    it 'user hast to be signed in' do
      @headers[:token] = ''

      json_edit_password @user, @headers
      expect(response).to have_http_status(401)
    end

    it 'current password has to be valid' do
      @user[:current_password] = '123456789'

      json_edit_password @user, @headers
      expect(response).to have_http_status(401)
    end

    it 'password has be valid and confirmated' do
      @user[:password] = '1234'
      @user[:password_confirmation] = '1234'      

      json_edit_password @user, @headers
      expect(response).not_to have_http_status(200)

      @user[:password] = '123456'
      @user[:password_confirmation]= '1234567'

      json_edit_password @user, @headers
      expect(response).not_to have_http_status(200)
    end

  end

end