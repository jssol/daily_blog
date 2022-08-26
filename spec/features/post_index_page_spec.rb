require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  before :each do
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
    @first_post = Post.create(author: @first_user, title: 'Hello', text: 'This is my first post')
    Comment.create(post: @first_post, author: @second_user, text: 'Hi Tom!' )
    Comment.create(post: @first_post, author: @second_user, text: 'Hi Mom!' )
    visit user_posts_path(@first_user.id)
  end

  describe 'index page' do
    it 'I can see the user\'s profile picture.' do
      page.has_selector?('img')
    end
    it 'I can see the user\'s username.' do
      expect(page).to have_content 'Tom'
    end
    it 'I can see the number of posts the user has written' do
      expect(page).to have_content('Number of posts: 1')
    end
    it 'I can see a post\'s title' do
      expect(page).to have_content 'Hello'
    end
    it 'I can see some of the post\'s body' do
      expect(page).to have_content 'This is my first post'
    end

    it 'I can see how many comments a post has.' do
      expect(page).to have_content 'Comments: 2'
    end

    it 'I can see how many likes a post has.' do
      expect(page).to have_content 'Likes: 0'
    end

    it 'I can see a section for pagination if there are more posts than fit on the view.' do
      new_post_link = find('button > a')
      expect(new_post_link).to have_content 'New Post'
    end

    it 'When I click on a post, it redirects me to that post\'s show page.' do
      click_link 'See Post'
      expect(current_path).to eq user_post_path(@first_user.id, @first_post.id)
    end
  end
end
