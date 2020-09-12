class Api::UnlocksController < Devise::UnlocksController
  respond_to :json

  def create
    resource_params = resource_class.find_by(email: params[:user][:email])

    if resource_params.blank?
      render json: { 
        error: { 
          email: [I18n.t('.devise.failure.email_not_found')] 
        } 
      }, status: :unprocessable_entity
    else
      self.resource = resource_class.send_unlock_instructions(email: params[:user][:email])
      yield resource if block_given?
  
      if successfully_sent?(resource)
        render json: { status: 'ok' }, status: :ok
      else
        render json: { error: I18n.t('.devise.failure.send_error') }, status: :unprocessable_entity
      end
    end
  end

  def show
    if resource_class.find_by(email: params[:user][:email]).blank?
      render json: { 
        error: { 
          email: [I18n.t('.devise.failure.email_not_found')] 
        } 
      }, status: :unprocessable_entity
    else
      self.resource = resource_class.unlock_access_by_token(params[:user][:unlock_token])
      yield resource if block_given?
  
      if resource.errors.empty?
        render json: { status: 'ok' }, status: :ok
      else
        render json: { error: resource.errors }, status: :unprocessable_entity
      end
    end
  end
end