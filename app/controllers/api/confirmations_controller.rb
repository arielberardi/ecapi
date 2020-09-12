class Api::ConfirmationsController < Devise::ConfirmationsController
  respond_to :json

  def show   
    if resource_class.find_by(email: params[:user][:email]).blank?
      render json: { 
        error: { 
          email: [I18n.t('.devise.failure.email_not_found')] 
        } 
      }, status: :unprocessable_entity
    else
      self.resource = resource_class.confirm_by_token(params[:user][:confirmation_token])
      yield resource if block_given?
  
      if resource.errors.empty?
        render json: { status: 'ok' }, status: :ok
      else
        render json: { error: resource.errors }, status: :unprocessable_entity
      end
    end
  end
end
