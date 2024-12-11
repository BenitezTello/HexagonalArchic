# app/domain/vehicle_repository.rb

class VehicleRepository
  def save(vehicle)
    raise NotImplementedError, "Este método debe ser implementado por una subclase"
  end

  def find_by_id(id)
    raise NotImplementedError, "Este método debe ser implementado por una subclase"
  end

  def find_all
    raise NotImplementedError, "Este método debe ser implementado por una subclase"
  end
end

