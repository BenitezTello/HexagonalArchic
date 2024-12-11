# app/infrastructure/web/user_controller.rb
require 'sinatra'
require_relative '../../application/user_service'
require_relative '../../infrastructure/persistence/active_record_user_repository'
require_relative '../../application/vehicle_service'
require_relative '../../infrastructure/persistence/active_record_vehicle_repository'

user_repository = ActiveRecordUserRepository.new
user_service = UserService.new(user_repository)

vehicle_repository = ActiveRecordVehicleRepository.new
vehicle_service = VehicleService.new(vehicle_repository)

enable :sessions

# Método para obtener el usuario actual
helpers do
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

# Ruta para mostrar el formulario de login
get '/login' do
  @vehicles = vehicle_service.list_all_vehicles
  erb :login
end

# Ruta para manejar el login
post '/login' do
  username = params[:username]
  password = params[:password]

  user = user_service.authenticate_user(username, password)
  if user
    session[:user_id] = user.id
    session[:role] = user.role  # Guardar el rol del usuario en la sesión
    redirect '/'
  else
    "Credenciales inválidas. Por favor, inténtelo de nuevo."
  end
end


# Ruta para mostrar el formulario de registro
get '/register' do
  erb :register
end

# Ruta para manejar el registro
post '/register' do
  username = params[:username]
  password = params[:password]

  user_service.register_user(username, password)
  redirect '/login'
end

# Ruta para cerrar sesión
get '/logout' do
  session.clear
  redirect '/'
end


