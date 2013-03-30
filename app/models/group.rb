class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :memos
  attr_accessible :expiration, :name, :users
  
end
