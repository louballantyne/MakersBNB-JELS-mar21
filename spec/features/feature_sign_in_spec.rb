# frozen_string_literal: true

feature 'sign in' do
  scenario 'A user can sign in' do
    visit '/'
    click_button 'Sign in'
    expect(page).to have_content 'Username'
    expect(page).to have_content 'Password'
  end
end
