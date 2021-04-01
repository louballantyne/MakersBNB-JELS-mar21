# frozen_string_literal: true

feature 'edit' do
  scenario 'allows user to edit existing listing' do
    visit '/'
    click_on 'Sign up'
    fill_in('first_name', with: 'Theodore')
    fill_in('last_name', with: 'Humpernickle')
    fill_in('username', with: 'ttotheh')
    fill_in('email', with: 'theodore@humpernickle.com')
    fill_in('password', with: 'ilovesweeties')
    fill_in('confirm', with: 'ilovesweeties')
    click_button 'Submit'

    click_button 'Add listing'
    fill_in('name', with: 'Pretty house')
    fill_in('sleeps', with: '2')
    fill_in('bedrooms', with: '1')
    fill_in('bathrooms', with: '2')
    fill_in('description', with: 'This is a pretty house')
    fill_in('price', with: '50')
    select('House', from: 'type')
    click_button 'Submit'
    click_button 'Edit'

    expect(page).to have_content 'Name'
    expect(page).to have_content 'Sleeps'
    expect(page).to have_content 'Bedrooms'
    expect(page).to have_content 'Bathrooms'
    expect(page).to have_content 'Description'
    expect(page).to have_content 'Type'
    expect(page).to have_content 'Price'

  end
end
