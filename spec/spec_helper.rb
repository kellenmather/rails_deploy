def create_user name='kobe', email='kobe@lakers.com', password='password', password_confirmation='password'
  User.create(name: name, email: email, password: password, password_confirmation: password_confirmation)
end
def log_in user, password='password'
  visit '/sessions/new'
  fill_in 'user[email]', with: user.email
  fill_in 'user[password]', with: password
  click_button 'Login'
end
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
