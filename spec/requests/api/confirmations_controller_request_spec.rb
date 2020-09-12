require 'rails_helper'
require './spec/support/authentication_helper'

RSpec.configure do |c|
  c.include AuthenticationHelpers
end

RSpec.describe "Api::ConfirmationsControllers", type: :request do

  before (:each) do
    @user = create_fake_user
    @user.confirmed_at = nil
    @user.save!

    @user_json = {
      email: @user.email,
      confirmation_token: @user.confirmation_token
    }
  end

  context 'confirmating token' do
    it 'user email has to be valid' do
      @user_json[:email] = 'test1@test.com'

      json_confirmation_token @user_json
      expect(response).to have_http_status(422)
    end

    it 'token has to be valid' do
      @user_json[:confirmation_token] = '123ashfkjdas123'

      json_confirmation_token @user_json
      expect(response).to have_http_status(422)
    end

    it 'token has not be used before' do
      @user.confirmed_at = Time.now
      @user.save!

      json_confirmation_token @user_json
      expect(response).to have_http_status(422)
    end
  end

end