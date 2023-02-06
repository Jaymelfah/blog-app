require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'post index action' do
    before :each do
      @user = User.create(
        name: 'Tom', photo: 'https://images.unsplash.com/photo-1545167622-3a6ac756afa4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=712&q=80',
        bio: 'Teacher from Mexico.',
        posts_counter: 1
      )
      get "/users/#{@user.id}/posts"
    end
  end

  describe 'post show action' do
    before :each do
      @user = User.create(name: 'Tom', photo: 'https://images.unsplash.com/photo-1545167622-3a6ac756afa4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=712&q=80',
                          bio: 'Teacher from Mexico.',
                          posts_counter: 1)
      @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post', user_id: @user.id,
                          author_id: @user.id, likes_counter: 0, comments_counter: 0)
      get "/users/#{@user.id}/posts/#{@post.id}"
    end

    it 'should check if correct index template is rendered' do
      expect(response).to render_template(:show)
    end
  end
end
