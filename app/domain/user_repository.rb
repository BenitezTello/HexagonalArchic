# app/domain/user_repository.rb

class UserRepository
  def save(user)
    raise NotImplementedError, "Este método debe ser implementado por una subclase"
  end

  def find_by_username(username)
    raise NotImplementedError, "Este método debe ser implementado por una subclase"
  end
end
