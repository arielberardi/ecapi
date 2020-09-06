class ApplicationController < ActionController::API
  respond_to :json
  acts_as_token_authentication_handler_for User, fallback: :exception

  def index
    render json: {
      status: 'ok',
      response: 'This is a index test page'
    }, status: :ok
  end

end
