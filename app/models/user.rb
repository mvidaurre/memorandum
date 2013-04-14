class User < ActiveRecord::Base
	before_create :generate_api_token
  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :memos
  has_many :user_read_memos
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :api_token
  validates :email, :first_name, :last_name, :password, :password_confirmation, :presence => true
  validates :email, :uniqueness => true, :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :message => "Invalid email format" }

private
  
  def generate_api_token
    begin
      self.api_token = SecureRandom.hex
    end while self.class.exists?(api_token: api_token)
  end

end
