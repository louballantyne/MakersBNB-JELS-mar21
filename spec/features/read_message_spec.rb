feature 'read messages' do
  scenario 'A user reads a message sent to them about their listing' do
    visit '/'
    click_button 'Sign in'
    fill_in('username', with: 'poshhouseperson')
    fill_in('password', with: 'password1')
    click_button 'Submit'
    click_button 'Messages'
    expect(page).to have_text 'What an amazing castle!'
  end
end
