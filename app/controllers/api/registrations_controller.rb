class Api::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  acts_as_token_authentication_handler_for User, fallback: :exception, 
    only: [:edit, :update, :destroy]

  respond_to :json

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if resource     
      resource_updated = update_resource(resource, account_update_params)
      yield resource if block_given?
      if resource_updated
        bypass_sign_in resource, scope: resource_name      
        render json: {status: 'ok'}, status: :ok
      else
        clean_up_passwords resource
        set_minimum_password_length
        render json: {error: resource.errors }, status: :unprocessable_entity
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { 
      |u| u.permit(:first_name, :last_name, :address, :born_date, :email, :password, :password_confirmation)
    }
    
    devise_parameter_sanitizer.permit(:account_update) { 
      |u| u.permit(:first_name, :last_name, :address, :born_date, :email, :password, :current_password)
    }
  end

  private

  def authenticate_scope!
  end
end
