# frozen_string_literal: true

feature 'sign up' do
  scenario 'A user can sign up' do
    visit '/'
    click_on 'Sign up'

    expect(page).to have_content 'First name'
    expect(page).to have_content 'Last name'
    expect(page).to have_content 'Username'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
    expect(page).to have_content 'Confirm password'
  end
  scenario 'A user will see their name, sign out and add listing after they create an account' do
    visit '/'
    click_on 'Sign up'
    # FIRST NAME IS RENAMED TO NAME TEMPORARILY
    fill_in('first_name', with: 'Theodore')
    fill_in('last_name', with: 'Humpernickle')
    fill_in('username', with: 'ttotheh')
    fill_in('email', with: 'theodore@humpernickle.com')
    fill_in('password', with: 'ilovesweeties')
    fill_in('confirm', with: 'ilovesweeties')
    click_on 'Submit'

    expect(page).to have_text 'Theodore'
    expect(page).to have_button 'Sign out'
    expect(page).to have_button 'Add listing'
  end
end
