require 'rails_helper'
require './spec/support/authentication_helper'

RSpec.configure do |c|
  c.include AuthenticationHelpers
end

RSpec.describe "Api::SessionsControllers", type: :request do

  before (:each) do
    @user = create_fake_user
  end

  context 'signing in' do

    before (:each) do
      @user_json = {
        email: User.first.email,
        password: '123456'
      }
    end

    it 'with valid email, password after mail confirmation' do
      json_sign_in @user_json   
      expect(response).to have_http_status(201)        
    end

    it 'with invalid email' do
      @user_json[:email] = 'test123@test.com'

      json_sign_in @user_json
      expect(response).to have_http_status(401)
    end

    it 'with invalid password' do
      @user_json[:password] = 'test123@test.com'

      json_sign_in @user
      expect(response).to have_http_status(401)
    end

    it 'before confirmation mail' do
      @user.confirmed_at = nil
      @user.save!

      json_sign_in @user_json
      expect(response).to have_http_status(401)
    end
  end

  context 'signing out' do

    before (:each) do
      @user_json = {
        email: User.first.email,
        authentication_token: User.first.authentication_token
      }
    end

    it 'before signing in' do
      @user_json[:authentication_token] = nil
      json_sign_out @user_json
      expect(response).to have_http_status(401)
    end

    it 'after signing in' do
      json_sign_out @user_json
      expect(response).to have_http_status(200)
    end
  end

end
