class UserReadMemo < ActiveRecord::Base
  belongs_to :user
  belongs_to :memo
  attr_accessible :read
end
