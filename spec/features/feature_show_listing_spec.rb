feature 'show listing' do 
  scenario 'you van view a listing by clicking on it' do 
    visit '/'

    first('.listing_preview').click_on 'poshhouse'

    expect(page).to have_text 'poshhouse'
    expect(page).to have_text 'London'
    expect(page).to have_text 'small castle'
    expect(page).to have_content 'blah blah posh house blah blaaah'
  end 
end 