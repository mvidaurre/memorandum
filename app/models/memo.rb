class Memo < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :user_read_memos
  attr_accessible :description, :due_date, :title, :group, :user, :user_read_memos_count
	validates :description, :due_date, :title, :presence => true
end
