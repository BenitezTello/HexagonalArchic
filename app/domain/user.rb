# app/domain/user.rb
class User < ActiveRecord::Base
  # Usamos BCrypt para encriptar las contraseñas
  include BCrypt

  # Validaciones
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true

  # Virtual attribute para la contraseña
  attr_accessor :password

  # Antes de guardar, encripta la contraseña
  before_save :encrypt_password

  # Método de autenticación
  def self.authenticate(username, password)
    user = find_by(username: username)
    return user if user && Password.new(user.password_digest) == password
    nil
  end

  # Método para verificar si el usuario es admin
  def admin?
    self.role == 'admin'  # Verifica si el rol es 'admin'
  end

  private

  def encrypt_password
    self.password_digest = Password.create(password) if password.present?
  end
end
