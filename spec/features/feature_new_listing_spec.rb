feature 'new' do 
  scenario 'you can add a new listing' do 
    visit '/'
    click_on 'Sign up'
    # FIRST NAME IS RENAMED TO NAME TEMPORARILY
    fill_in('name', with: 'Theodore')
    fill_in('last_name', with: 'Humpernickle')
    fill_in('username', with: 'ttotheh')
    fill_in('email', with: 'theodore@humpernickle.com')
    fill_in('password', with: 'ilovesweeties')
    fill_in('confirm', with: 'ilovesweeties')
    click_on 'Submit'
    click_on 'Add listing'

    expect(page).to have_content 'name'
    expect(page).to have_content 'city'
    expect(page).to have_content 'county'
    expect(page).to have_content 'sleeps'
    expect(page).to have_content 'bedrooms'
    expect(page).to have_content 'bathrooms'
    expect(page).to have_content 'description'
    expect(page).to have_content 'type'
  end 
end 