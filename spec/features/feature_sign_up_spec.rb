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
end 