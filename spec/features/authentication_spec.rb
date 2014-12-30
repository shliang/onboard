require 'spec_helper'

feature 'authentication' do
  scenario 'signing up with email' do
    sign_up('me@hugomelo.com', 'password')
    expect(page).to have_content 'A message with a confirmation link has been sent to your email address'
  end

  scenario 'deleting your account' do
    sign_up('me@hugomelo.com', 'password')
    log_in('me@hugomelo.com', 'password')
    click_link 'Account'
    click_button 'Cancel my account'
    expect(page).to have_content 'Bye! Your account was successfully cancelled.'
  end
end

feature 'attaching social accounts' do
  scenario 'attaching social accounts to a user' do
    sign_up('me@hugomelo.com', 'password')
    log_in('me@hugomelo.com', 'password')

    visit '/users/edit'
    click_link 'Connect Twitter'
    expect(User.first.services.length).to eq 1

    visit '/users/edit'
    click_link 'Connect Facebook'
    expect(User.first.services.length).to eq 2
  end

  scenario 'removing a social account' do
    sign_up('me@hugomelo.com', 'password')
    log_in('me@hugomelo.com', 'password')
    user = User.first

    visit '/users/edit'
    click_link 'Connect Twitter'
    expect(user.services.length).to eq 1

    click_link 'Account'
    click_link 'Delete Service'
    expect(page).to have_content 'Successfully disconnected account'
    expect(user.reload.services.length).to eq 0
  end
end
