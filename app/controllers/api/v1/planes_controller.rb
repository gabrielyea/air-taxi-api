class Api::V1::PlanesController < ApplicationController
  before_action :set_plane, only: %i[show update destroy]
  before_action :authenticate_user!

  def index
    render json: current_user.planes
  end

  def show
    render json: @plane
  end

  def create
    @plane = Plane.new(plane_params)

    if @plane.save
      render json: @plane, status: :created, location: @plane
    else
      render json: @plane.errors, status: :unprocessable_entity
    end
  end

  def update
    if @plane.update(plane_params)
      render json: @plane
    else
      render json: @plane.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @plane.destroy
  end

  private

  def set_plane
    @plane = Plane.find(params[:id])
  end

  def plane_params
    params.require(:plane).permit(:model, :registration, :description, :cruise_speed, :tour_price, :reservation_id)
  end
end
