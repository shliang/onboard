require 'spec_helper'

feature 'managing user profile data' do
  scenario 'chainging email' do
    expected_email = 'hugo@example.com'
    sign_up('me@hugomelo.com', 'password')
    log_in('me@hugomelo.com', 'password')
    click_link 'Account'

    fill_in 'Email', with: expected_email
    fill_in 'Current password', with: 'password'
    click_button 'Update'
    user = User.first
    user.confirm!
    expect(user.email).to eq expected_email
  end

  scenario 'changing password' do
    expected_password = 'new password'
    sign_up('me@hugomelo.com', 'password')
    log_in('me@hugomelo.com', 'password')
    click_link 'Account'

    fill_in 'Password', with: expected_password
    fill_in 'Password confirmation', with: expected_password
    fill_in 'Current password', with: 'password'
    click_button 'Update'
    user = User.first
    expect(user.valid_password?(expected_password)).to be_truthy
  end
end

feature 'viewing user profiles' do
  scenario 'seeing all profiles' do
    sign_up('me@hugomelo.com', 'password')
    sign_up('you@hugomelo.com', 'password')
    log_in('me@hugomelo.com', 'password')

    visit '/profiles'
    expect(page).to have_content 'me@hugomelo.com'
    expect(page).to have_content 'you@hugomelo.com'
  end

  scenario 'seeing a single profile' do
    sign_up('me@hugomelo.com', 'password')
    log_in('me@hugomelo.com', 'password')

    visit '/profile/' + User.first.id.to_s
    expect(page).to have_content 'me@hugomelo.com'
  end
end
