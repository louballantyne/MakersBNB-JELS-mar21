# frozen_string_literal: true

feature 'show listing' do
  scenario 'you van view a listing by clicking on it' do
    visit '/'

    first('.listing_preview').click_on 'poshhouse'

    expect(page).to have_text 'poshhouse'
    expect(page).to have_text 'London'
    expect(page).to have_text 'small castle'
    expect(page).to have_content 'blah blah posh house blah blaaah'
  end
  scenario 'you can edit a listing, if you were the one who created it' do
    visit '/'

    click_on 'Sign in'
    fill_in 'username', with: 'poshhouseperson'
    fill_in 'password', with: 'password1'
    click_on 'Submit'

    first('.listing_preview').click_on 'poshhouse'
    click_on 'Edit'

    expect(page).to have_content 'Name'
    expect(page).to have_content 'Sleeps'
  end

  scenario 'it shows the start and the end date for when the listing is available' do 
    visit '/'

    first('.listing_preview').click_on 'The bath house'
    expect(page).to have_text 'Available from: 2021-04-03'
    expect(page).to have_text 'Until: 2021-04-04'
  end 
end
