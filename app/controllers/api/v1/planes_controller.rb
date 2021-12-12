class Api::V1::PlanesController < Api::V1::BaseController
  before_action :set_plane, only: %i[show update destroy]

  def index
    render json: Plane.all
  end

  def show
    render json: @plane
  end

  def create
    @plane = Plane.new(plane_params)
    if @plane.save
      render json: { data: @plane }, status: :created
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
    render json: { message: 'Plane record deleted' }, status: :ok
  end

  private

  def set_plane
    @plane = Plane.find(params[:id])
  end

  def plane_params
    params.require(:plane).permit(
      :model, :registration, :description, :cruise_speed, :tour_price, :reservation_id, :picture
    )
  end
end
