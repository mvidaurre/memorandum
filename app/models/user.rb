class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :memos
  has_many :user_read_memos
  attr_accessible :email, :first_name, :last_name, :password
  validates :email, :first_name, :last_name, :password, :presence => true
  validates :email, :uniqueness => true, :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :message => "Invalid email format" }
end
