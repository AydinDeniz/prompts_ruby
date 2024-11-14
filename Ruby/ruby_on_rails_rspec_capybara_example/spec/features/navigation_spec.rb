
require 'rails_helper'

RSpec.feature 'Navigation', type: :feature do
  scenario 'User navigates to the home page' do
    visit root_path
    expect(page).to have_text('Home')
  end

  scenario 'User navigates to the about page' do
    visit about_path
    expect(page).to have_text('About Us')
  end
end
