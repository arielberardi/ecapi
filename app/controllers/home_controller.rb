class HomeController < ApplicationController
  acts_as_token_authentication_handler_for User, fallback: :exception
  respond_to :json

  def index
    render json: {
      status: 'ok',
      response: 'This is a index test page',
    }, status: :ok
  end
end