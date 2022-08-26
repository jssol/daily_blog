require 'rails_helper'

RSpec.describe 'User', type: :feature do
  before :each do
    first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Poland.')
    first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
    Comment.create(post: first_post, author: second_user, text: 'Hi Tom!')
    Comment.create(post: first_post, author: second_user, text: 'Hi Mom!')
    visit user_path(first_user.id)
  end

  describe 'show page' do
    it 'should show the profile picture the user' do
      all_images = page.all('img')
      all_images.each do |img|
        link = img[:src]
        expect(link).to eq('https://unsplash.com/photos/F_-0BxGuVvo')
      end
    end

    it 'shows the username' do
      expect(page).to have_content('Tom')
    end

    it 'should show the number of posts each user has written' do
      expect(page).to have_content('Number of posts: 1')
    end

    it 'should show the user bio' do
      expect(page).to have_content('Teacher from Mexico.')
    end

    it 'should show the user latest posts' do
      user_posts = all('ul > li')
      expect(user_posts.count).to eql(1)
    end

    it 'should show the More Posts link' do
      expect(page).to have_content 'More Posts'
    end

    it 'should show Post index page' do
      click_link('More Posts', match: :first)
      expect(page).to have_content 'See Post'
    end
  end
end
