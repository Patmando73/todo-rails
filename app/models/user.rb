

class User < ActiveRecord::Base
  has_many :tasks
  include BCrypt


  def encrypt_password(unencrypted_password)
    self.password = BCrypt::Password.create(unencrypted_password)
  end
end
