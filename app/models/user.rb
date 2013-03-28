class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, :through => :memberships
  attr_accessible :email, :first_name, :last_name, :password
end