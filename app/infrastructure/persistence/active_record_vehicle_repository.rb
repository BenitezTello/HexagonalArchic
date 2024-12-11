# app/infrastructure/persistence/active_record_vehicle_repository.rb

require_relative '../../domain/vehicle_repository'
require_relative '../../domain/vehicle'

class ActiveRecordVehicleRepository < VehicleRepository
  def save(vehicle)
    vehicle.save
  end

  def find_by_id(id)
    Vehicle.find(id)
  end

  def find_all
    Vehicle.all
  end
end