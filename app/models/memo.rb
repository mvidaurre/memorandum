class Memo < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  attr_accessible :description, :due_date, :title, :group, :user
end
