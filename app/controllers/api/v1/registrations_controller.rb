class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    render json: { message: 'User deleted' }, status: :ok
  end

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: { data: UserSerializer.new(resource).serializable_hash[:data][:attributes] }, status: :ok
  end

  def register_failed
    render json: { message: 'Something went wrong.' }, status: :unprocessable_entity
  end
end
