class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :memos
  attr_accessible :email, :first_name, :last_name, :password
end
