class Api::V1::PlanesController < ApplicationController
  before_action :set_plane, only: %i[show update destroy]
  before_action :authenticate_user!

  # GET /planes
  def index
    render json: current_user.planes
  end

  # GET /planes/1
  def show
    render json: @plane
  end

  # POST /planes
  def create
    @plane = Plane.new(plane_params)

    if @plane.save
      render json: @plane, status: :created, location: @plane
    else
      render json: @plane.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /planes/1
  def update
    if @plane.update(plane_params)
      render json: @plane
    else
      render json: @plane.errors, status: :unprocessable_entity
    end
  end

  # DELETE /planes/1
  def destroy
    @plane.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_plane
    @plane = Plane.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def plane_params
    params.require(:plane).permit(:model, :registration, :description, :cruise_speed, :tour_price, :reservation_id)
  end
end
