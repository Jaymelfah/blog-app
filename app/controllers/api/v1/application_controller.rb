class Api::V1::ApplicationController < ActionController::API
    respond_to :json
  
    before_action :authenticate_user!
  
    def authenticate_user!
      token = request.headers['Authorization']&.split&.last
      payload = JwtHandler.decode(token)
  
      if payload
        @current_user = CurrentUser.new(payload['id'], payload['email'])
        render json: { jwt: token, user: @current_user }, status: :ok
      else
        render json: { error: 'Not Authorized' }, status: :unauthorized
      end
    end
end