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


require_relative '../app/infrastructure/web/payment_controller'
require_relative '../app/application/payments_service'
require_relative '../app/infrastructure/persistence/active_record_payment_repository'
require_relative '../app/infrastructure/persistence/active_order_payment_repository'

# Establecer configuraciones para las vistas
set :views, File.expand_path('../app/views', __FILE__)

# Configuraciones adicionales si es necesario
puts "Entorno configurado correctamente"
