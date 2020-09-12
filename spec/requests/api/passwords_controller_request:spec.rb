require 'rails_helper'
require './spec/support/authentication_helper'

RSpec.configure do |c|
  c.include AuthenticationHelpers
end

RSpec.describe "Api::PasswordsControllers", type: :request do

  before (:each) do
    create_fake_user
  end

  context 'request new password token' do

    before (:each) do
      @user = {
        email: User.first.email
      }
    end

    it 'register users can ask for password token' do
      json_forgot_password @user
      expect(respose).to have_http_status(200)
    end

    it 'non register users can not ask for password token' do
      @user[:email] = 'test1@test.com'
      json_forgot_password @user
      expect(respose).not_to have_http_status(200)
    end

  end

  context 'request edit password' do

    before (:each) do
      @user = {
        email: User.first.email,
        reset_password_token: User.first.reset_password_token,
        password: '123456',
        password_confirmation: '123456'
      }
    end

    it 'with valid token can edit password' do
      json_reset_password @user
      expect(response).to have_http_status(200)
    end

    it 'with invalid token can not edit password' do
      @user[:reset_password_token] = nil

      json_reset_password @user
      expect(response).to have_http_status(200)
    end

    it 'only with valid password and confirmation' do
      @user[:password] = ''
      @user[:password_confirmation] = ''
      json_reset_password @user
      expect(response).not_to have_http_status(200)

      @user[:password] = '123456'
      @user[:password_confirmation] = '1234567'
      json_reset_password @user
      expect(response).not_to have_http_status(200)
    end

  end

end