def set_omniauth(opts = {})
  default = {:provider => :facebook,
             :uuid     => "1234",
             :facebook => {
                            :email => "foobar@example.com",
                            :gender => "Male",
                            :first_name => "foo",
                            :last_name => "bar"
                          }
            }

  credentials = default.merge(opts)
  provider = credentials[:provider]
  user_hash = credentials[provider]

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[provider] = {
    'uid' => credentials[:uuid],
    "extra" => {
    "user_hash" => {
      "email" => user_hash[:email],
      "first_name" => user_hash[:first_name],
      "last_name" => user_hash[:last_name],
      "gender" => user_hash[:gender]
      }
    }
  }
end

def sign_up(email, password)
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password
  click_button 'Sign up'
  User.find_by_email(email).confirm!
end

def log_in(email, password)
  click_link 'Sign in'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Sign in'
end
