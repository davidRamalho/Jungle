class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { in: 6..20 }
  
  def authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase); 
    if user && user.authenticate(password)
      return user
    else 
      return nil
    end
  end

end
