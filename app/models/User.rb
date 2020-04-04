class User < ActiveRecord::Base
  has_many :excursions

  has_secure_password
  
end