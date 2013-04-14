class CreateUserReadMemos < ActiveRecord::Migration
  def change
    create_table :user_read_memos do |t|
      t.boolean :read
      t.references :user
      t.references :memo

      t.timestamps
    end
    add_index :user_read_memos, :user_id
    add_index :user_read_memos, :memo_id
  end
end
