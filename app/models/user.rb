class User < ActiveRecord::Base
  has_secure_password

  # Validations
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, :presence => true, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }
  validates :fn, :ln, :presence => true, length: { minimum: 2 }
end
