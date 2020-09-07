class ConfirmationsController < Devise::ConfirmationsController
  respond_to :json

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      render json: { status: 'ok', singed_in: signed_in?(resource_name)}, status: :ok
    else
      render json: { error: resource.errors}, status: :unprocessable_entity
    end
  end

end
