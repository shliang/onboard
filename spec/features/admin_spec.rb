require 'spec_helper'

feature 'admin user' do
  scenario 'admin managing normal users' do
    sign_up('me@hugomelo.com', 'password')
    sign_up('you@hugomelo.com', 'password')
    sign_up('u2@hugomelo.com', 'password')

    user = User.first
    user.confirm!
    user.update_attribute(:role, 'admin')
    visit '/'
    log_in('me@hugomelo.com', 'password')

    visit '/admin'
    expect(page).to have_content 'you@hugomelo.com'
    expect(page).to have_content 'u2@hugomelo.com'
  end
end
