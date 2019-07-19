# As a User,
# so that I can save a bookmark,
# I want to be able to add a new bookmark to the list

feature 'Adding a new bookmark' do
  scenario 'A user can add a bookmark to Bookmark Manager' do
    visit('/bookmarks/new')
    fill_in('url', with: 'http://testbookmark.com')
    fill_in('title', with: 'test bookmark')
    click_button('Submit')

    expect(page).to have_link('test bookmark', href: 'http://testbookmark.com')
  end
  
  scenario 'The bookmark must be a valid URL' do
  visit('/bookmarks/new')
  fill_in('url', with: 'not a real bookmark')
  click_button('Submit')

  expect(page).not_to have_content "not a real bookmark"
  expect(page).to have_content "You must submit a valid URL."
end
end
