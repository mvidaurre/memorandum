class CreateMemos < ActiveRecord::Migration
  def change
    create_table :memos do |t|
      t.string :title
      t.string :description
      t.date :due_date
      t.references :group
      t.references :user

      t.timestamps
    end
    add_index :memos, :group_id
    add_index :memos, :user_id
  end
end
