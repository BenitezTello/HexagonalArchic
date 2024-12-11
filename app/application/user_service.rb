require_relative '../domain/user'  # Requerir el archivo del modelo User

class UserService
    def initialize(user_repository)
      @user_repository = user_repository
    end
  
    def register_user(username, password)
      # Hashear la contraseña antes de guardarla
      password_digest = BCrypt::Password.create(password)
      user = User.new(username: username, password_digest: password_digest)
      @user_repository.save(user)
    end
  
    def authenticate_user(username, password)
      user = @user_repository.find_by_username(username)
      if user && BCrypt::Password.new(user.password_digest) == password
        user
      else
        nil
      end
    end
end