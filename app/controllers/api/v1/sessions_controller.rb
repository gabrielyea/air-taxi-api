class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _opts = {})
    user = User.find_by_email(sign_in_params[:email])

    if user&.valid_password?(sign_in_params[:password])
      render json: { message: 'You are logged in.' }, status: :ok
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: 'You are logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
  end
end
