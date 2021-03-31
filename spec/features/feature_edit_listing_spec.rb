feature 'edit' do
    scenario 'allows user to edit existing listing' do
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
        fill_in('name', with: 'Pretty house')
        fill_in('sleeps', with: '2')
        fill_in('bedrooms', with: '1')
        fill_in('bathrooms', with: '2')
        fill_in('description', with: 'This is a pretty house')
        select('House', :from => 'type')
        click_on 'Submit'
        click_on 'Edit'

        expect(page).to have_content ''

        
    end

end

