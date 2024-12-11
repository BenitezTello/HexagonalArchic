# app/infrastructure/web/vehicle_controller.rb

require 'sinatra'
require 'json'
require 'fileutils'
require_relative '../../application/vehicle_service'
require_relative '../persistence/active_record_vehicle_repository'

# Crear una instancia del repositorio y el servicio
repository = ActiveRecordVehicleRepository.new
service = VehicleService.new(repository)

# Método auxiliar para obtener el usuario actual
helpers do
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    nil
  end

  # Inicializa el carrito en la sesión si no existe
  def cart
    session[:cart] ||= {}
  end

  # Agrega un vehículo al carrito
  def add_to_cart(vehicle_id)
    if cart[vehicle_id]
      cart[vehicle_id] += 1
    else
      cart[vehicle_id] = 1
    end
  end

  # Remueve un vehículo del carrito
  def remove_from_cart(vehicle_id)
    cart.delete(vehicle_id)
  end

  # Limpia el carrito
  def clear_cart
    session[:cart] = {}
  end

  # Obtiene los vehículos en el carrito
  def cart_items
    Vehicle.where(id: cart.keys)
  end

  # Calcula el total del carrito
  def cart_total
    cart_items.reduce(0) do |sum, vehicle|
      sum + (vehicle.price.to_f * cart[vehicle.id.to_s].to_i)
    end
  end
end
# Ruta para agregar un vehículo al carrito
post '/cart/add' do
  vehicle_id = params[:vehicle_id]
  
  # Verificar si el vehículo existe
  vehicle = service.find_vehicle(vehicle_id)
  if vehicle
    add_to_cart(vehicle_id)
    flash[:success] = "#{vehicle.brand} #{vehicle.model} ha sido agregado al carrito."
  else
    flash[:error] = "Vehículo no encontrado."
  end
  
  redirect back
end
get '/cart' do
  @cart_items = cart_items
  @cart = cart
  @total = cart_total
  erb :cart
end

post '/cart/remove' do
  vehicle_id = params[:vehicle_id]
  
  remove_from_cart(vehicle_id)
  flash[:success] = "Vehículo ha sido removido del carrito."
  
  redirect '/cart'
end

# app/infrastructure/web/vehicle_controller.rb

# Ruta para limpiar el carrito
post '/cart/clear' do
  clear_cart
  flash[:success] = "El carrito ha sido vacío."
  redirect '/cart'
end


# Ruta para crear un vehículo (solo accesible para el rol "admin")
get '/vehicles/new' do
  redirect '/vehicles' unless session[:user_id] && current_user.admin?
  erb :vehicle_new  # Muestra el formulario para crear un nuevo vehículo
end

# Ruta para editar un vehículo (solo accesible para el rol "admin")
get '/vehicles/:id/edit' do
  redirect '/vehicles' unless session[:user_id] && current_user.admin?
  @vehicle = service.find_vehicle(params[:id])
  erb :vehicle_edit  # Muestra el formulario para editar un vehículo
end

# Ruta para ver un vehículo específico
get '/vehicles/:id' do
  @vehicle = service.find_vehicle(params[:id])
  erb :vehicle_detail
end

# Ruta para listar todos los vehículos
get '/vehicles' do
  @vehicles = service.list_all_vehicles
  erb :dashboard  # Vista que muestra los vehículos disponibles
end

# Ruta principal, muestra los vehículos en el dashboard
get '/' do
  @vehicles = service.list_all_vehicles
  erb :dashboard
end

# Ruta para manejar la creación de un vehículo
post '/vehicles' do
  redirect '/vehicles' unless session[:user_id] && current_user.admin?

  vehicle_params = {
    brand: params['brand'],
    model: params['model'],
    year: params['year'],
    price: params['price'].to_f
  }

  if params[:image] && params[:image][:filename] && params[:image][:tempfile]
    filename = params[:image][:filename]
    file = params[:image][:tempfile]

    # Validar extensión del archivo
    allowed_extensions = %w(.jpg .jpeg .png .gif)
    ext = File.extname(filename).downcase
    unless allowed_extensions.include?(ext)
      halt 400, "Tipo de archivo no permitido."
    end

    # Crear directorio si no existe
    upload_dir = "./public/uploads"
    FileUtils.mkdir_p(upload_dir) unless Dir.exist?(upload_dir)

    # Generar nombre único
    unique_filename = "#{Time.now.to_i}_#{filename}"
    file_path = "#{upload_dir}/#{unique_filename}"

    begin
      File.open(file_path, 'wb') do |f|
        f.write(file.read)
      end
      vehicle_params[:image_url] = "/uploads/#{unique_filename}"
    rescue => e
      halt 500, "Error al guardar la imagen: #{e.message}"
    end
  end

  service.register_vehicle(vehicle_params)
  redirect '/vehicles'
end

# Ruta para manejar la edición de un vehículo
post '/vehicles/:id' do
  redirect '/vehicles' unless session[:user_id] && current_user.admin?

  vehicle_params = {
    brand: params['brand'],
    model: params['model'],
    year: params['year'],
    price: params['price'].to_f
  }

  if params[:image] && params[:image][:filename] && params[:image][:tempfile]
    filename = params[:image][:filename]
    file = params[:image][:tempfile]

    # Validar extensión del archivo
    allowed_extensions = %w(.jpg .jpeg .png .gif)
    ext = File.extname(filename).downcase
    unless allowed_extensions.include?(ext)
      halt 400, "Tipo de archivo no permitido."
    end

    # Crear directorio si no existe
    upload_dir = "./public/uploads"
    FileUtils.mkdir_p(upload_dir) unless Dir.exist?(upload_dir)

    # Generar nombre único
    unique_filename = "#{Time.now.to_i}_#{filename}"
    file_path = "#{upload_dir}/#{unique_filename}"

    begin
      File.open(file_path, 'wb') do |f|
        f.write(file.read)
      end
      vehicle_params[:image_url] = "/uploads/#{unique_filename}"
    rescue => e
      halt 500, "Error al guardar la imagen: #{e.message}"
    end
  end

  service.update_vehicle(params[:id], vehicle_params)
  redirect '/vehicles'
end

# Ruta para eliminar un vehículo (solo accesible para el rol "admin")
get '/vehicles/:id/delete' do
  redirect '/vehicles' unless session[:user_id] && current_user.admin?
  service.delete_vehicle(params[:id])
  redirect '/vehicles'
end
