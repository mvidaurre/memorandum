class UserReadMemo < ActiveRecord::Base
  belongs_to :user
  belongs_to :memo, :counter_cache => true
  attr_accessible :read
end
