require_relative '../../domain/user_repository'
require_relative '../../domain/user'
class ActiveRecordUserRepository
    def save(user)
      user.save
    end
  
    def find_by_username(username)
      User.find_by(username: username)
    end
  end