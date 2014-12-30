require 'spec_helper'
require 'pry-rescue'

feature 'authentication' do
  scenario 'signing up with email' do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'me@hugomelo.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content 'A message with a confirmation link has been sent to your email address'
  end
end

feature 'attaching social accounts' do
  scenario 'attaching social accounts to a user' do
    # Sign up
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'me@hugomelo.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    # Log in
    User.first.confirm!
    click_link 'Sign in'
    fill_in 'Email', with: 'me@hugomelo.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    # Add twitter account
    visit '/users/edit'
    click_link 'Connect Twitter'
    expect(User.first.services.length).to eq 1

    # Add Facebook account
    visit '/users/edit'
    click_link 'Connect Facebook'
    expect(User.first.services.length).to eq 2
  end

  scenario 'removing a social account' do
    # Sign up
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'me@hugomelo.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    user = User.first
    user.confirm!

    click_link 'Sign in'
    fill_in 'Email', with: 'me@hugomelo.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    # Add Twitter account
    visit '/users/edit'
    click_link 'Connect Twitter'
    expect(user.services.length).to eq 1

    # Remove Twitter account
    click_link 'Account'
    click_link 'Delete Service'
    expect(page).to have_content 'Successfully disconnected account'
    expect(user.reload.services.length).to eq 0
  end
end
