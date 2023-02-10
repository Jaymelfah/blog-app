# spec/controllers/api/v1/comments_controller_spec.rb
# require 'rails_helper'
require 'swagger_helper'

RSpec.describe Api::V1::CommentsController, type: :request do
  describe 'GET /api/v1/users/:user_id/posts/:post_id/comments' do
    it 'returns status code 200' do
      user = 736
      post = 693
      get api_v1_user_post_comments_path(user, post)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/users/:user_id/posts/:post_id/comments' do
    it 'checks if post has been added' do
      valid_attributes = {
        post_id: 693,
        user_id: 736,
        author_id: 736,
        text: 'This is me'
      }
      post api_v1_user_post_comments_path(valid_attributes)
      expect(response).to have_http_status(200)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['text']).to eq('This is me')
    end
  end
end
