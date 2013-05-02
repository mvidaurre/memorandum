class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  attr_accessible :admin, :user, :group

  validates :user_id, :uniqueness => {:scope=>:group_id}
end
