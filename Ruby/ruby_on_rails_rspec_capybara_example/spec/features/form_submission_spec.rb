
require 'rails_helper'

RSpec.feature 'FormSubmission', type: :feature do
  scenario 'User submits form successfully' do
    visit '/forms/new'
    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: 'john.doe@example.com'
    click_button 'Submit'

    expect(page).to have_text('Form submitted successfully')
  end

  scenario 'User submits form with errors' do
    visit '/forms/new'
    fill_in 'Name', with: ''
    fill_in 'Email', with: 'invalid-email'
    click_button 'Submit'

    expect(page).to have_text('Please enter a valid name and email')
  end
end
