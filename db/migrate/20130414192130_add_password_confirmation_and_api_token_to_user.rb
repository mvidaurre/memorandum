class AddPasswordConfirmationAndApiTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_confirmation, :string
    add_column :users, :api_token, :string
  end
end
