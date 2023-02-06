require 'rails_helper'

RSpec.describe 'User Page Index', type: :feature do
  before :each do
    @tom = User.create(name: 'Tommy', photo: 'https://images.unsplash.com/photo-1545167622-3a6ac756afa4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=712&q=80', bio: 'Teacher', posts_counter: 3)
    @post1 = Post.create(title: 'Hello', text: 'My world', comments_counter: 0, likes_counter: 0, user_id: @tom.id, author_id: @tom.id)
    @post2 = Post.create(title: 'Hi', text: 'My earth', comments_counter: 0, likes_counter: 0, user_id: @tom.id, author_id: @tom.id)
    @post3 = Post.create(title: 'Hey', text: 'My universe', comments_counter: 0, likes_counter: 0, user_id: @tom.id, author_id: @tom.id)
    visit user_path(@tom.id)
  end

  it 'shows the profile picture of the user' do
    assert page.has_xpath?("//img[@src = 'https://images.unsplash.com/photo-1545167622-3a6ac756afa4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=712&q=80' and @alt='user photo']")
  end

  it 'shows the username' do
    expect(page).to have_content(@tom.name)
  end
end
