class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  has_many :memos
  attr_accessible :expiration, :name, :users, :owner

  validates :name, :expiration, :owner, :presence => true
end
