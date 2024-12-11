require 'sinatra'
require 'active_record'
require 'bcrypt'
require 'sinatra/flash'

# Configuración de ActiveRecord
ActiveRecord::Base.establish_connection(
  adapter: 'sqlserver',
  host: '172.17.0.1',
  port: 1433,
  database: 'sinatra',
  username: 'sa',
  password: 'YourStrong@Passw0rd'
)

# Requerir archivos de dominio y repositorio
require_relative 'app/domain/vehicle'
require_relative 'app/domain/user'

require_relative 'app/infrastructure/persistence/active_record_vehicle_repository'
require_relative 'app/infrastructure/persistence/active_record_user_repository'

require_relative 'app/application/vehicle_service'
require_relative 'app/application/user_service'

require_relative 'app/infrastructure/web/vehicle_controller'
require_relative 'app/infrastructure/web/user_controller'

# Configura las vistas correctamente
set :views, File.expand_path('../app/views', __FILE__)


# Configuraciones de Sinatra
set :bind, '0.0.0.0'
set :port, 3000 