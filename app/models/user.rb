

class User < ActiveRecord::Base
  has_many :tasks
  include BCrypt


  def correct_password?(attempted_password)
    BCrypt::Password.new(self.password) == attempted_password
  end

  def encrypt_password(unencrypted_password)
    self.password = BCrypt::Password.create(unencrypted_password)
  end
end
