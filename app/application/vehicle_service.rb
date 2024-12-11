# app/application/vehicle_service.rb

class VehicleService
  def initialize(repository)
    @repository = repository
  end

  def register_vehicle(params)
    vehicle = Vehicle.new(
      brand: params[:brand],
      model: params[:model],
      year: params[:year],
      price: params[:price],
      image_url: params[:image_url]
    )
    @repository.save(vehicle)
  end

  def find_vehicle(id)
    @repository.find_by_id(id)
  end

  def list_all_vehicles
    @repository.find_all
  end

  def update_vehicle(id, params)
    vehicle = @repository.find_by_id(id)
    return unless vehicle

    vehicle.brand = params[:brand] if params[:brand]
    vehicle.model = params[:model] if params[:model]
    vehicle.year = params[:year] if params[:year]
    vehicle.price = params[:price] if params[:price]
    vehicle.image_url = params[:image_url] if params[:image_url]

    @repository.save(vehicle)
  end

  def delete_vehicle(id)
    vehicle = @repository.find_by_id(id)
    vehicle.destroy if vehicle
  end
end

