require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
   it 'returns a list of bookmarks' do

     Bookmark.create(url: 'http://www.makersacademy.com', title: 'makers academy')
     Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'destroy all software')
     Bookmark.create(url: 'http://www.google.com', title: 'google')


     # Add the test data
     # connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")
     # connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.destroyallsoftware.com');")
     # connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")

     bookmarks = Bookmark.all
     expect(bookmarks[0].url).to include('http://www.makersacademy.com')
     expect(bookmarks[1].url).to include('http://www.destroyallsoftware.com')
     expect(bookmarks[2].url).to include('http://www.google.com')
   end
 end

 describe '.create' do
   it 'creates a new bookmark' do
     bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'test bookmark')
     persisted_data = persisted_data(table: 'bookmarks', id: bookmark.id)
     expect(bookmark.id).to eq persisted_data.first['bookmark_id']
     expect(bookmark.title).to eq 'test bookmark'
   end
   it 'does not create a new bookmark if the URL is not valid' do
     Bookmark.create(url: 'not a real bookmark', title: 'not a real bookmark')
     expect(Bookmark.all).not_to include 'not a real bookmark'
   end
 end

  describe '.delete' do
    it 'deletes the given bookmark' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')

      Bookmark.delete(id: bookmark.id)

      expect(Bookmark.all.length).to eq 0
    end
  end

  describe '.update' do
    it 'updates a bookmark' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
   updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.snakersacademy.com', title: 'Snakers Academy')

   expect(updated_bookmark).to be_a Bookmark
   expect(updated_bookmark.id).to eq bookmark.id
   expect(updated_bookmark.title).to eq 'Snakers Academy'
   expect(updated_bookmark.url).to eq 'http://www.snakersacademy.com'
   end
end

  describe '.find' do
    it 'returns the requested bookmark object' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')

      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Makers Academy'
      expect(result.url).to eq 'http://www.makersacademy.com'
    end
  end
end
