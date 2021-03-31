# frozen_string_literal: true

feature 'sign out' do
  scenario 'A user signs in and then signs out' do
    visit '/'
    click_on 'Sign in'
    fill_in('username', with: 'poshhouseperson')
    fill_in('password', with: 'password1')
    click_button 'Submit'
    click_button 'Sign out'
    expect(page).to have_button 'Sign in'
  end
end
