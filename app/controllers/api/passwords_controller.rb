class Api::PasswordsController < Devise::PasswordsController
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
      self.resource = resource_class.send_reset_password_instructions(email: params[:user][:email])
      yield resource if block_given?
  
      if successfully_sent?(resource)
        render json: { status: 'ok' }, status: :ok
      else
        render json: { error: I18n.t('.devise.failure.send_error') }, status: :unprocessable_entity
      end
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(params[:user])
    yield resource if block_given?

    if resource.errors.empty?
      render json: { status: 'ok' }, status: :ok
    else
      set_minimum_password_length
      render json: { error: resource.errors }, status: :unprocessable_entity
    end
  end 
end


