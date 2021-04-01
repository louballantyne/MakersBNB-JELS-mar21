feature 'send messages' do
  scenario 'A user sends a message to another user about their listing' do
    visit '/'
    click_button 'Sign in'
    fill_in('username', with: 'cheaphouseperson')
    fill_in('password', with: 'password1')
    click_button 'Submit'
    first('.listing_preview').click_on 'poshhouse'
    click_button 'Message user'
    fill_in 'message', with: 'Your house looks so posh'
    click_button 'Send'
    expect(page).to have_text 'Message sent!'
  end
end
