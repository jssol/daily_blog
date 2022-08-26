require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'tests the #index action' do
    before(:each) do
      get '/users'
    end

    it 'should render the correct template' do
      expect(response).to render_template(:index)
    end

    it 'should have the correct placeholder text' do
      expect(response.body).to include('Name: Gomez')
    end

    it 'should have a correct response status' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'tests the #show action' do
    before :each do
      first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                               bio: 'Teacher from Mexico.')
      second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                bio: 'Teacher from Poland.')
      first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
      Comment.create(post: first_post, author: second_user, text: 'Hi Tom!')
      Comment.create(post: first_post, author: second_user, text: 'Hi Mom!')
      get user_path(first_user.id)
    end

    it 'should render the correct template' do
      expect(response).to render_template(:show)
    end

    it 'should have the correct placeholder text' do
      expect(response.body).to include('Mexico')
    end

    it 'should have a correct response status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
