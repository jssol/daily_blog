require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  before :each do
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Mexico.')
    @second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                               bio: 'Teacher from Poland.')
    @first_post = Post.create(author: @first_user, title: 'Hello', text: 'This is my first post')
    Comment.create(post: @first_post, author: @second_user, text: 'Hi Tom!')
    Comment.create(post: @first_post, author: @second_user, text: 'Hi Mom!')
    visit user_post_path(@first_user.id, @first_post.id)
  end

  describe 'Post' do
    it 'I can see the post\'s title.' do
      expect(page).to have_content 'Hello'
    end
    it 'Can see who wrote the post' do
      expect(page).to have_content 'Tom'
    end
    it 'Can see how many comments it has' do
      expect(page).to have_content 'Comments: 2'
    end
    it 'Can see how many likes it has' do
      expect(page).to have_content 'Likes: 0'
    end
    it 'Can see the post body' do
      expect(page).to have_content 'This is my first post'
    end
    it 'Can see the username of each commentor' do
      expect(page).to have_content 'Lilly'
    end
    it 'Can see the comment each commentor left' do
      expect(page).to have_content 'Hi Tom!'
      expect(page).to have_content 'Hi Mom!'
    end
  end
end
