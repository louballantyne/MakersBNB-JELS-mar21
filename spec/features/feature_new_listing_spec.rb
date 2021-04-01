feature 'new' do
  scenario 'you can add a new listing' do
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

    expect(page).to have_content 'Name'
    expect(page).to have_content 'City'
    expect(page).to have_content 'Country'
    expect(page).to have_content 'Sleeps'
    expect(page).to have_content 'Bedrooms'
    expect(page).to have_content 'Bathrooms'
    expect(page).to have_content 'Description'
    expect(page).to have_content 'Type'
  end 
end 
