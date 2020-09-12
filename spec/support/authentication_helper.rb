module AuthenticationHelpers
  
  def create_fake_user
    User.create(
      first_name: 'FakeFirstName',
      last_name: 'FakeLastName',
      address: 'Fake Street 123, Fake Country',
      born_date: 15.years.ago,
      email: 'test@test.com',
      password: '123456', 
      password_confirmation: '123456', 
      authentication_token: "FalseTokenAuthentication",
      confirmation_token: "FalseTokenAuthentication",
      confirmed_at: Time.now,
    )
  end

  def json_sign_in user
    post api_sign_in_url, params: { user: user }
  end

  def json_sign_out user
    headers_name = SimpleTokenAuthentication.header_names[:user]
    
    headers = {
      "Content-Type" => "application/json",
      "#{headers_name[:email]}" => user[:email],
      "#{headers_name[:token]}" => user[:authentication_token]
    }

    delete api_sign_out_url, params: nil, headers: headers
  end

  def json_sign_up user
    post api_sign_up_url, params: { user: user }
  end

  def json_forgot_password user
    post api_password_forgot_url, params: { user: user }
  end

  def json_reset_password user
    post api_password_reset_url, params: { user: user }
  end

  def json_edit_password user, headers
    post api_password_edit_url, params: { user: user }, headers: headers
  end
 
  def json_confirmation_token user
    post api_confirmation_url, params: { user: user }
  end

  def json_unlock_create user
    post api_unlock_create_url, params: { user: user }
  end

  def json_unlock_reset user
    post api_unlock_reset_url, params: { user: user }
  end
end 