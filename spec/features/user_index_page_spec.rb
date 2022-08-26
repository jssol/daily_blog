require 'rails_helper'

RSpec.describe 'User', type: :feature do
  before :each do
    first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
    first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
    Comment.create(post: first_post, author: second_user, text: 'Hi Tom!' )
    Comment.create(post: first_post, author: second_user, text: 'Hi Mom!' )
    visit users_path
  end

  describe 'index page' do
    it 'shows the usernames' do
      expect(page).to have_content('Tom')
      expect(page).to have_content('Lilly')
    end

    it "should show the profile picture for each user" do
      all_images = page.all('img')
      all_images.each do |img|
        link = img[:src]
        expect(link).to eq('https://unsplash.com/photos/F_-0BxGuVvo')
      end
    end

    it "should show the number of posts each user has written" do
      expect(page).to have_content('Number of posts: 1')
      expect(page).to have_content('Number of posts: 0')
    end

    it "should show the number of posts each user has written" do
      click_link('More', match: :first)
      expect(page).to have_content 'Bio'
    end
  end
end
