feature 'availability' do
    scenario 'allows user to add availability to their listing' do
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
        click_button 'Add availability'

        expect(page).to have_text('Start date (DD/MM/YYYY):', 'End date (DD/MM/YYYY):')
    end

end