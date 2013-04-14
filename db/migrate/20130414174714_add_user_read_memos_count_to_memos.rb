class AddUserReadMemosCountToMemos < ActiveRecord::Migration
  def change
  	add_column :memos, :user_read_memos_count, :integer, defaut: 0
  end
end
