class User < ApplicationRecord
  has_secure_password

  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.downcase.strip)
    return nil unless user
    return nil unless user.authenticate(password)
    user
  end
  
end
