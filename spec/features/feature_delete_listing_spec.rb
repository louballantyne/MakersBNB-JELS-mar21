# frozen_string_literal: true

feature 'delete listing' do
  scenario 'If a user owns a listing they can choose to delete it' do
    visit '/'
    click_on 'Sign in'
    fill_in('username', with: 'poshhouseperson')
    fill_in('password', with: 'password1')
    click_button 'Submit'
    click_on 'poshhouse'
    click_button 'Delete listing'
    expect(page).to have_button('Add listing')
  end
end
