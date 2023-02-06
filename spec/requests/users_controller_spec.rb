require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'user index action' do
    before :each do
      get users_path
    end

    it 'should check if status was correct' do
      expect(response).to have_http_status(200)
    end

    it 'should check if correct index template is rendered' do
      expect(response).to render_template(:index)
    end
  end

  context 'user show action' do
    before :each do
      @user = User.create(
        name: 'Tom',
        photo: 'https://images.unsplash.com/photo-1545167622-3a6ac756afa4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=712&q=80',
        bio: 'Teacher from Mexico.',
        posts_counter: 1
      )
      get user_path(@user.id)
    end

    it 'should check if status was correct' do
      expect(response).to have_http_status(200)
    end

    it 'should check if correct index template is rendered' do
      expect(response).to render_template(:show)
    end
  end
end
