
require 'rails_helper'

RSpec.feature 'UserLogin', type: :feature do
  scenario 'User logs in with valid credentials' do
    user = User.create(email: 'test@example.com', password: 'password')

    visit '/login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(page).to have_text('Welcome, \#{user.email}')
  end

  scenario 'User logs in with invalid credentials' do
    visit '/login'
    fill_in 'Email', with: 'wrong@example.com'
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Log in'

    expect(page).to have_text('Invalid email or password')
  end
end
