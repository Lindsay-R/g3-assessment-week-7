require 'spec_helper'

feature 'Homepage' do
  scenario 'Shows the welcome message' do
    visit '/'

    expect(page).to have_content 'Welcome!'
    fill_in 'name', with: 'Lindsay'
    fill_in 'message', with: 'This is a message.'
    click_button "Add Message"
    expect(page).to have_content 'This is a message.'
    expect(page).to have_content 'Lindsay'
  end
end