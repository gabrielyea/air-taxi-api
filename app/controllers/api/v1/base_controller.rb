class Api::V1::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :authenticate_user!

  def not_found
    render json: { message: 'Record not found :c' }
  end
end
