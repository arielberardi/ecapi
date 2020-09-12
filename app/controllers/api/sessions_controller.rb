class Api::SessionsController < Devise::SessionsController
  acts_as_token_authentication_handler_for User, fallback: :exception, only: [:destroy]
  respond_to :json

  def destroy
    current_user.authentication_token = nil
    current_user.authentication_token_created_at = Time.now
    current_user.save!

    render json: { status: 'ok' }, status: :ok
  end

  private

  def respond_to_on_destroy
  end
end
