# Cambiar la ruta incorrecta de product_controller a vehicle_controller
# Cargar el controlador de vehículos
require_relative '../app/infrastructure/web/vehicle_controller'

# Requerir el servicio y repositorio de vehículos
require_relative '../app/application/vehicle_service'
require_relative '../app/infrastructure/persistence/in_memory_vehicle_repository'

# Requerir el controlador y repositorio de usuarios
require_relative '../app/infrastructure/web/user_controller'
require_relative '../app/application/user_service'
require_relative '../app/infrastructure/persistence/active_record_user_repository'

# Establecer configuraciones para la vista (si usas vistas)
set :views, File.expand_path('../app/views', __FILE__)

# Configuraciones adicionales si es necesario
puts "Entorno configurado correctamente"
